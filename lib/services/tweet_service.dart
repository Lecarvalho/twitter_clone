import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitter_clone/models/tweet_reaction_model.dart';
import 'package:twitter_clone/models/tweet_model.dart';

import 'providers/database_provider.dart';
import 'tweet_service_base.dart';

class TweetService extends TweetServiceBase {
  late DatabaseProvider _database;

  Collections get _collections => _database.collections;

  TweetService(DatabaseProvider provider) : super(provider) {
    _database = provider;
  }

  @override
  Future<void> createTweet(Map<String, dynamic> map) async {
    final batch = _database.firestore.batch();
    final createdAt = DateTime.now().toUtc();

    //1. create tweet
    final newTweetDoc = _collections.tweets.doc();

    batch.set(newTweetDoc, map);

    //2. create a feed for myself
    _createAFeed(
      batch: batch,
      createdAt: createdAt,
      creatorTweetProfileId: map[Fields.profileId],
      concernedProfileId: map[Fields.profileId],
      newTweetDoc: newTweetDoc,
    );

    //3. create feed for my followers
    final followersMap =
        await _collections.followers.doc(map[Fields.profileId]).toMap();

    if (followersMap != null) {
      followersMap.keys.forEach((followerId) {
        _createAFeed(
          batch: batch,
          newTweetDoc: newTweetDoc,
          creatorTweetProfileId: map[Fields.profileId],
          concernedProfileId: followerId,
          createdAt: createdAt,
        );
      });
    }

    await batch.commit();
  }

  @override
  Future<List<TweetModel>?> getTweets(String myProfileId) async {
    List<TweetModel> tweets = [];

    final feedList = await _collections.feed
        .where(Fields.concernedProfileId, isEqualTo: myProfileId)
        .orderBy(Fields.createdAt, descending: true)
        .limit(20)
        .toMapList();

    feedList.distinct((feed) => feed[Fields.tweetId]);

    if (feedList.isNotEmpty) {
      for (var oneFeed in feedList) {
        final tweet =
            await _toTweetModel(oneFeed[Fields.tweetId], oneFeed, myProfileId);

        if (tweet != null) tweets.add(tweet);
      }
    }

    return tweets.isNotEmpty ? tweets : null;
  }

  @override
  Future<TweetModel?> getTweet(String tweetId, String myProfileId) async {
    return await _collections.tweets.doc(tweetId).toModel<TweetModel>(
          (tweetMap) =>
              _getMyReactions(TweetModel.fromMap(tweetMap), myProfileId),
        );
  }

  Future<TweetModel?> _toTweetModel(
    String tweetId,
    Map<String, dynamic> feedMap,
    String myProfileId,
  ) async {
    final tweet = await _collections.tweets.doc(tweetId).toModel<TweetModel>(
          (data) => TweetModel.fromMap(data),
        );

    if (tweet != null) {
      if (feedMap[Fields.reactedByProfileId] != null) {
        tweet.tweetReaction = TweetReactionModel.fromMap(feedMap);
      }

      await _getMyReactions(tweet, myProfileId);

      return tweet;
    }
  }

  Future<TweetModel> _getMyReactions(
      TweetModel tweet, String myProfileId) async {
    tweet.didILike = await _collections.reactions.docExists(
      _collections.toReactionKey(tweet.id, myProfileId, ReactionTypes.like),
    );

    tweet.didIRetweet = await _collections.reactions.docExists(
      _collections.toReactionKey(tweet.id, myProfileId, ReactionTypes.retweet),
    );

    return tweet;
  }

  // @override
  // Stream<FeedChangesResponse> listenFeed(String myProfileId) async* {
  //   final myFeedStreamSnapshot = _collections.feed
  //       .where(Fields.concernedProfileId, isEqualTo: myProfileId)
  //       .orderBy(Fields.createdAt, descending: true)
  //       .limit(20)
  //       .snapshots();

  //   await for (var myFeedSnapshoot in myFeedStreamSnapshot) {
  //     yield await _toListTweetModel(myFeedSnapshoot, myProfileId);
  //   }
  // }

  // @override
  // Stream<TweetModel> listenReactions(String tweetId) async* {
  //   final tweetStreamSnapshot = _collections.tweets.doc(tweetId).snapshots();

  //   await for (var tweetSnapshot in tweetStreamSnapshot) {
  //     if (tweetSnapshot.exists) {
  //       var tweet = await tweetSnapshot.reference.toModel<TweetModel>(
  //         (tweetMap) => TweetModel.fromMap(tweetMap),
  //       );
  //       yield tweet!;
  //     }
  //   }
  // }

  // Future<FeedChangesResponse> _toListTweetModel(
  //   QuerySnapshot snapshot,
  //   String myProfileId,
  // ) async {
  //   List<TweetModel> changedTweets = [];
  //   List<String> deletedTweetIds = [];
  //   for (var feedDoc in snapshot.docChanges) {
  //     final feedMap = feedDoc.doc.data();
  //     final tweetId = feedMap![Fields.tweetId];

  //     if (feedDoc.newIndex != -1) {
  //       //updated
  //       final tweet = await _toTweetModel(tweetId, feedMap, myProfileId);
  //       if (tweet != null) changedTweets.add(tweet);
  //     } else {
  //       // deleted from feed, check if it was not just an undo reaction
  //       var previousFeedRef = await _collections.feed
  //           .where(Fields.concernedProfileId, isEqualTo: myProfileId)
  //           .where(Fields.tweetId, isEqualTo: tweetId)
  //           .orderBy(Fields.createdAt, descending: true)
  //           .limit(1)
  //           .toMapList();

  //       if (previousFeedRef.isNotEmpty) {
  //         final tweet =
  //             await _toTweetModel(tweetId, previousFeedRef.first, myProfileId);
  //         if (tweet != null) changedTweets.add(tweet);
  //       } else {
  //         //it was really removed from the user's feed
  //         deletedTweetIds.add(tweetId);
  //       }
  //     }
  //   }

  //   return FeedChangesResponse(
  //     changedTweets: changedTweets,
  //     deletedTweetIds: deletedTweetIds,
  //   );
  // }

  @override
  Future<List<TweetModel>?> getProfileTweets(
    String profileId,
    String myProfileId,
  ) async {
    List<TweetModel> tweets = [];

    final myTweetsFeed = await _collections.feed
        .where(Fields.creatorTweetProfileId, isEqualTo: profileId)
        .orderBy(Fields.createdAt, descending: true)
        .limit(10)
        .toMapList();

    final myReactionsFeed = await _collections.feed
        .where(Fields.reactedByProfileId, isEqualTo: profileId)
        .orderBy(Fields.createdAt, descending: true)
        .limit(10)
        .toMapList();

    final feedList = myTweetsFeed + myReactionsFeed;

    feedList.distinct((feed) => feed[Fields.tweetId]);

    if (feedList.isNotEmpty) {
      for (var oneFeed in feedList) {
        final tweet =
            await _toTweetModel(oneFeed[Fields.tweetId], oneFeed, myProfileId);

        if (tweet != null) tweets.add(tweet);
      }
    }

    return tweets.isNotEmpty ? tweets : null;
  }

  @override
  Future<void> likeTweet(
    String tweetId,
    String ofProfileId,
    String myProfileId,
    String myProfileName,
  ) async {
    final createdAt = DateTime.now().toUtc();
    final tweetRef = _collections.tweets.doc(tweetId);
    final reactionRef = _collections.reactions.doc(
      _collections.toReactionKey(tweetId, myProfileId, ReactionTypes.like),
    );

    _database.firestore.runTransaction((transaction) async {
      var tweetDoc = await transaction.get(tweetRef);

      if (tweetDoc.exists) {
        var tweetMap = (await tweetDoc.reference.toMap())!;
        int likeCount = tweetMap[Fields.likeCount] ?? 0;
        likeCount++;
        transaction.update(tweetRef, {Fields.likeCount: likeCount});

        transaction.set(reactionRef, {
          Fields.createdAt: createdAt,
          Fields.reactionType: ReactionTypes.like,
          Fields.tweetId: tweetId,
          Fields.reactedByProfileId: myProfileId,
        });
      }
    });
  }

  @override
  Future<void> unlikeTweet(
    String tweetId,
    String ofProfileId,
    String myProfileId,
  ) async {
    var tweetRef = _collections.tweets.doc(tweetId);
    final reactionRef = _collections.reactions.doc(
      _collections.toReactionKey(tweetId, myProfileId, ReactionTypes.like),
    );

    _database.firestore.runTransaction((transaction) async {
      var tweetDoc = await transaction.get(tweetRef);

      if (tweetDoc.exists) {
        var tweetMap = (await tweetDoc.reference.toMap())!;
        int likeCount = tweetMap[Fields.likeCount] ?? 0;
        likeCount--;
        transaction.update(tweetRef, {Fields.likeCount: likeCount});

        transaction.delete(reactionRef);
      }
    });
  }

  @override
  Future<void> retweet(
    String tweetId,
    String ofProfileId,
    String myProfileId,
    String myProfileName,
  ) async {
    var batch = _database.firestore.batch();
    final createdAt = DateTime.now().toUtc();
    var tweetRef = _collections.tweets.doc(tweetId);

    //up retweet
    int retweetCount = await _getRetweetCount(tweetRef);

    retweetCount++;

    batch.update(tweetRef, {Fields.retweetCount: retweetCount});

    // set a feed for myself
    _setReactionOnFeed(
      batch: batch,
      concernedProfileId: myProfileId,
      createdAt: createdAt,
      creatorTweetProfileId: ofProfileId,
      reactedByProfileId: myProfileId,
      reactedByProfileName: myProfileName,
      reactionType: ReactionTypes.retweet,
      tweetId: tweetId,
    );

    // set feed for my followers
    final myFollowersMap =
        await _collections.followers.doc(myProfileId).toMap();

    if (myFollowersMap != null) {
      myFollowersMap.keys.forEach((myFollowerId) {
        _setReactionOnFeed(
          batch: batch,
          concernedProfileId: myFollowerId,
          createdAt: createdAt,
          creatorTweetProfileId: ofProfileId,
          reactedByProfileId: myProfileId,
          reactedByProfileName: myProfileName,
          reactionType: ReactionTypes.retweet,
          tweetId: tweetId,
        );
      });
    }

    _createAReaction(
      batch: batch,
      createdAt: createdAt,
      reactedByProfileId: myProfileId,
      reactionType: ReactionTypes.retweet,
      tweetId: tweetId,
    );

    await batch.commit();
  }

  void _createAFeed({
    required WriteBatch batch,
    required DocumentReference newTweetDoc,
    required String creatorTweetProfileId,
    required String concernedProfileId,
    required DateTime createdAt,
  }) {
    final feedRef = _collections.feed.doc();

    batch.set(feedRef, {
      Fields.tweetId: newTweetDoc.id,
      Fields.creatorTweetProfileId: creatorTweetProfileId,
      Fields.concernedProfileId: concernedProfileId,
      Fields.createdAt: createdAt,
    });
  }
  Future<int> _getRetweetCount(DocumentReference tweetRef) async {
    final tweetMap = await tweetRef.toMap();

    return tweetMap![Fields.retweetCount] ?? 0;
  }

  void _setReactionOnFeed({
    required WriteBatch batch,
    required String tweetId,
    required String concernedProfileId,
    required String creatorTweetProfileId,
    required String reactionType,
    required String reactedByProfileId,
    required String reactedByProfileName,
    required DateTime createdAt,
  }) {
    final feedRef = _collections.feed.doc();

    batch.set(feedRef, {
      Fields.concernedProfileId: concernedProfileId,
      Fields.tweetId: tweetId,
      Fields.creatorTweetProfileId: creatorTweetProfileId,
      Fields.reactionType: reactionType,
      Fields.reactedByProfileName: reactedByProfileName,
      Fields.reactedByProfileId: reactedByProfileId,
      Fields.createdAt: createdAt,
    });
  }

  void _createAReaction({
    required String tweetId,
    required String reactedByProfileId,
    required DateTime createdAt,
    required WriteBatch batch,
    required String reactionType,
  }) {
    final reactionRef = _collections.reactions.doc(
      _collections.toReactionKey(tweetId, reactedByProfileId, reactionType),
    );

    batch.set(reactionRef, {
      Fields.createdAt: createdAt,
      Fields.reactionType: reactionType,
      Fields.tweetId: tweetId,
      Fields.reactedByProfileId: reactedByProfileId,
    });
  }

}
