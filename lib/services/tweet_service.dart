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
  Future<List<TweetModel>?> getProfileTweets(
    String profileId,
    String myProfileId,
  ) async {
    List<TweetModel> tweets = [];

    final myTweetsFeed = await _collections.feed
        .where(Fields.creatorTweetProfileId, isEqualTo: profileId)
        .limit(10)
        .toMapList();

    final myReactionsFeed = await _collections.feed
        .where(Fields.reactedByProfileId, isEqualTo: profileId)
        .limit(10)
        .toMapList();

    final feedList = myTweetsFeed + myReactionsFeed;

    feedList.distinct((feed) => feed[Fields.tweetId]);

    if (feedList.isNotEmpty) {
      tweets.addAll(
        await _getTweetsFromFeed(
          feedList: feedList,
          myProfileId: myProfileId,
        ),
      );
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
    final batch = _database.firestore.batch();
    final createdAt = DateTime.now().toUtc();
    final tweetRef = _collections.tweets.doc(tweetId);

    // up likeCount

    int likeCount = await _getLikeCount(tweetRef);

    likeCount++;

    batch.update(tweetRef, {Fields.likeCount: likeCount});

    // set a feed for myself
    _setReactionOnFeed(
      batch: batch,
      concernedProfileId: myProfileId,
      createdAt: createdAt,
      creatorTweetProfileId: ofProfileId,
      reactedByProfileId: myProfileId,
      reactedByProfileName: myProfileName,
      reactionType: ReactionTypes.like,
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
          reactionType: ReactionTypes.like,
          tweetId: tweetId,
        );
      });
    }

    _createAReaction(
      tweetId: tweetId,
      reactedByProfileId: myProfileId,
      createdAt: createdAt,
      batch: batch,
      reactionType: ReactionTypes.like,
    );

    await batch.commit();
  }

  @override
  Future<void> unlikeTweet(
    String tweetId,
    String ofProfileId,
    String myProfileId,
  ) async {
    final batch = _database.firestore.batch();
    var tweetRef = _collections.tweets.doc(tweetId);

    // down likeCount

    int likeCount = await _getLikeCount(tweetRef);

    likeCount--;

    batch.update(tweetRef, {Fields.likeCount: likeCount});

    await _removeLikeOnFeed(
      batch: batch,
      reactedByProfileId: myProfileId,
      tweetId: tweetId,
      creatorTweetProfileId: ofProfileId,
    );

    _removeAReaction(
      batch: batch,
      reactedByProfileId: myProfileId,
      reactionType: ReactionTypes.like,
      tweetId: tweetId,
    );

    await batch.commit();
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

  @override
  Future<TweetModel?> getTweet(String tweetId, String myProfileId) async {
    return await _collections.tweets.doc(tweetId).toModel<TweetModel>(
          (data) => _getMyReactions(TweetModel.fromMap(data), myProfileId),
        );
  }

  @override
  Future<List<TweetModel>?> getTweets(String myProfileId) async {
    List<TweetModel> tweets = [];

    final feedList = await _collections.feed
        .where(Fields.concernedProfileId, isEqualTo: myProfileId)
        .limit(20)
        // .orderBy(
        //   Fields.createdAt,
        //   descending: true,
        // )
        .toMapList();

    if (feedList.isNotEmpty) {
      tweets.addAll(
        await _getTweetsFromFeed(
          feedList: feedList,
          myProfileId: myProfileId,
        ),
      );
    }

    return tweets.isNotEmpty ? tweets : null;
  }

  Future<List<TweetModel>> _getTweetsFromFeed({
    required List<Map<String, dynamic>> feedList,
    required String myProfileId,
  }) async {
    List<TweetModel> tweets = [];

    for (var oneFeed in feedList) {
      final tweet = await _collections.tweets
          .doc(oneFeed[Fields.tweetId])
          .toModel<TweetModel>(
            (data) => TweetModel.fromMap(data),
          );

      if (tweet != null) {
        if (oneFeed[Fields.reactedByProfileId] != null) {
          tweet.tweetReaction = TweetReactionModel.fromMap(oneFeed);
        }

        tweet.didILike = await _collections.reactions.docExists(
          _collections.toReactionKey(tweet.id, myProfileId, ReactionTypes.like),
        );

        tweet.didIRetweet = await _collections.reactions.docExists(
          _collections.toReactionKey(
              tweet.id, myProfileId, ReactionTypes.retweet),
        );

        tweets.add(tweet);
      }
    }

    return tweets;
  }

  void _createAFeed({
    required WriteBatch batch,
    required DocumentReference newTweetDoc,
    required String creatorTweetProfileId,
    required String concernedProfileId,
    required DateTime createdAt,
  }) {
    final myFeedForMyself = _collections.feed.doc(
      _collections.toFeedKey(newTweetDoc.id, concernedProfileId),
    );

    batch.set(myFeedForMyself, {
      Fields.tweetId: newTweetDoc.id,
      Fields.creatorTweetProfileId: creatorTweetProfileId,
      Fields.concernedProfileId: concernedProfileId,
      Fields.createdAt: createdAt,
    });
  }

  Future<TweetModel> _getMyReactions(
    TweetModel tweet,
    String myProfileId,
  ) async {
    // did I like this tweet?
    final myLikeReaction = await _collections.reactions
        .doc(_collections.toReactionKey(
            tweet.id, myProfileId, ReactionTypes.like))
        .toModel<TweetReactionModel>(
            (data) => TweetReactionModel.fromMap(data));

    tweet.didILike = (myLikeReaction != null);
    tweet.tweetReaction = myLikeReaction;

    // did I retweet this tweet?
    final myRetweetReaction = await _collections.reactions
        .doc(_collections.toReactionKey(
            tweet.id, myProfileId, ReactionTypes.retweet))
        .toModel<TweetReactionModel>(
            (data) => TweetReactionModel.fromMap(data));

    tweet.didIRetweet = (myRetweetReaction != null);
    tweet.tweetReaction =
        tweet.didIRetweet ? myRetweetReaction : tweet.tweetReaction;

    return tweet;
  }

  Future<int> _getLikeCount(DocumentReference tweetRef) async {
    final tweetMap = await tweetRef.toMap();

    return tweetMap![Fields.likeCount] ?? 0;
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
    final feedRef = _collections.feed.doc(
      _collections.toFeedKey(tweetId, concernedProfileId),
    );

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

  Future<void> _removeLikeOnFeed({
    required WriteBatch batch,
    required String tweetId,
    required String reactedByProfileId,
    required String creatorTweetProfileId,
  }) async {
    final removeLikeFeed = await _collections.feed
        .where(Fields.tweetId, isEqualTo: tweetId)
        .where(Fields.reactionType, isEqualTo: ReactionTypes.like)
        .where(Fields.reactedByProfileId, isEqualTo: reactedByProfileId)
        .get();

    removeLikeFeed.docs.forEach((doc) async {
      final feedRef = doc.data()!;

      final followingMap = await _collections.following
          .doc(feedRef[Fields.concernedProfileId])
          .toMap();

      if (followingMap?.containsKey(creatorTweetProfileId) ?? false) {
        batch.set(doc.reference, {
          Fields.tweetId: tweetId,
          Fields.creatorTweetProfileId: creatorTweetProfileId,
          Fields.concernedProfileId: feedRef[Fields.concernedProfileId],
          Fields.createdAt: feedRef[Fields.createdAt],
        });
      } else {
        batch.delete(doc.reference);
      }
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

  void _removeAReaction({
    required String reactionType,
    required String reactedByProfileId,
    required String tweetId,
    required WriteBatch batch,
  }) {
    final reactionRef = _collections.reactions.doc(
      _collections.toReactionKey(tweetId, reactedByProfileId, reactionType),
    );

    batch.delete(reactionRef);
  }
}
