import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitter_clone/models/tweet_activity_model.dart';
import 'package:twitter_clone/models/tweet_model.dart';

import 'providers/database_provider.dart';
import 'tweet_service_base.dart';

class TweetService extends TweetServiceBase {
  late DatabaseProvider _database;

  TweetService(DatabaseProvider provider) : super(provider) {
    _database = provider;
  }

  @override
  Future<void> createTweet(Map<String, dynamic> map) async {
    final batch = _database.firestore.batch();
    final createdAt = DateTime.now().toUtc();

    //1. create tweet
    final newTweetDoc = _database.collections.tweets.doc();

    batch.set(newTweetDoc, map);

    //2. create a feed for myself
    final myFeedForMyself = _database.collections.feed.doc();

    batch.set(myFeedForMyself, {
      Fields.tweetId: newTweetDoc.id,
      Fields.creatorTweetProfileId: map[Fields.profileId],
      Fields.concernedProfileId: map[Fields.profileId],
      Fields.createdAt: createdAt,
    });

    //3. create feed for my followers
    final followersMap = await _database.collections.followers
        .doc(map[Fields.profileId])
        .toMap();

    if (followersMap != null) {
      followersMap.keys.forEach((followerId) {
        final newFeedRef = _database.collections.feed.doc();

        final dataFeedRef = {
          Fields.tweetId: newTweetDoc.id,
          Fields.creatorTweetProfileId: map[Fields.profileId],
          Fields.concernedProfileId: followerId,
          Fields.createdAt: createdAt,
        };

        batch.set(newFeedRef, dataFeedRef);
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

    final myTweetsFeed = await _database.collections.feed
        .where(Fields.creatorTweetProfileId, isEqualTo: profileId)
        .limit(10)
        .toMapList();

    final myReactionsFeed = await _database.collections.feed
        .where(Fields.reactedByProfileId, isEqualTo: profileId)
        .limit(10)
        .toMapList();

    final allFeed = myTweetsFeed + myReactionsFeed;

    allFeed.distinct((feed) => feed[Fields.tweetId]);

    if (allFeed.isEmpty) return null;

    for (var oneFeed in allFeed) {
      final tweet = await _database.collections.tweets
          .doc(oneFeed[Fields.tweetId])
          .toModel<TweetModel>(
            (data) => _getMyReactions(TweetModel.fromMap(data), myProfileId),
          );

      if (tweet != null) {
        tweets.add(tweet);
      }
    }

    return tweets.isNotEmpty ? tweets : null;
  }

  @override
  Future<TweetModel?> getTweet(String tweetId, String myProfileId) async {
    return await _database.collections.tweets.doc(tweetId).toModel<TweetModel>(
          (data) => _getMyReactions(TweetModel.fromMap(data), myProfileId),
        );
  }

  @override
  Future<List<TweetModel>?> getTweets(String myProfileId) async {
    List<TweetModel> tweets = [];

    final myFeedMapList = await _database.collections.feed
        .where(Fields.concernedProfileId, isEqualTo: myProfileId)
        .limit(20)
        .orderBy(
          Fields.createdAt,
          descending: true,
        )
        .toMapList();

    if (myFeedMapList.isNotEmpty) {
      myFeedMapList.distinct((feedMap) => feedMap[Fields.tweetId]);

      for (var myFeedMap in myFeedMapList) {
        final tweet = await _database.collections.tweets
            .doc(myFeedMap[Fields.tweetId])
            .toModel<TweetModel>(
              (data) => _getMyReactions(TweetModel.fromMap(data), myProfileId),
            );

        if (tweet != null) {
          // tweet is not deleted ?
          final reactionType = myFeedMap[Fields.reactionType];
          if (reactionType != null) {
            // retweet or like
            tweet.tweetActivity = TweetActivityModel.fromMap(myFeedMap);
          }

          tweets.add(tweet);
        }
      }
    }

    return tweets.isNotEmpty ? tweets : null;
  }

  Future<TweetModel> _getMyReactions(
      TweetModel tweet, String myProfileId) async {
    // didIReacted this tweet?
    final myReactions = await _database.collections.feed
        .where(Fields.tweetId, isEqualTo: tweet.id)
        .where(Fields.reactedByProfileId, isEqualTo: myProfileId)
        .where(Fields.concernedProfileId, isEqualTo: myProfileId)
        .toModelList<TweetActivityModel>(
          (data) => TweetActivityModel.fromMap(data),
        );

    if (myReactions.isNotEmpty) {
      tweet.didILike = myReactions
          .any((myReaction) => myReaction.tweetAction == TweetAction.like);

      tweet.didIRetweet = myReactions
          .any((myReaction) => myReaction.tweetAction == TweetAction.retweet);

      tweet.tweetActivity = myReactions.last;
    }

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

  @override
  Future<void> likeTweet(
    String tweetId,
    String ofProfileId,
    String myProfileId,
    String myProfileName,
  ) async {
    final batch = _database.firestore.batch();
    final createdAt = DateTime.now().toUtc();
    final tweetRef = _database.collections.tweets.doc(tweetId);

    // up likeCount

    int likeCount = await _getLikeCount(tweetRef);

    likeCount++;

    batch.update(tweetRef, {Fields.likeCount: likeCount});

    // set a feed for myself
    var myFeedWithMyReaction = _database.collections.feed.doc();

    batch.set(myFeedWithMyReaction, {
      Fields.concernedProfileId: myProfileId,
      Fields.tweetId: tweetId,
      Fields.creatorTweetProfileId: ofProfileId,
      Fields.reactionType: ReactionTypes.like,
      Fields.profileName: myProfileName,
      Fields.reactedByProfileId: myProfileId,
      Fields.createdAt: createdAt,
    });

    // set feed for my followers
    final myFollowersList =
        await _database.collections.followers.doc(myProfileId).toMap();

    if (myFollowersList != null) {
      myFollowersList.keys.forEach((myFollowerId) {
        final newFeedRef = _database.collections.feed.doc();

        batch.set(newFeedRef, {
          Fields.concernedProfileId: myFollowerId,
          Fields.tweetId: tweetId,
          Fields.creatorTweetProfileId: ofProfileId,
          Fields.reactionType: ReactionTypes.like,
          Fields.profileName: myProfileName,
          Fields.reactedByProfileId: myProfileId,
          Fields.createdAt: createdAt,
        });
      });
    }

    await batch.commit();
  }

  @override
  Future<void> unlikeTweet(
    String tweetId,
    String ofProfileId,
    String myProfileId,
  ) async {
    final batch = _database.firestore.batch();
    var tweetRef = _database.collections.tweets.doc(tweetId);

    // down likeCount

    int likeCount = await _getLikeCount(tweetRef);

    likeCount--;

    batch.update(tweetRef, {Fields.likeCount: likeCount});

    // remove my like from my feed
    final myLikeOnMyFeed = await _database.collections.feed
        .where(Fields.tweetId, isEqualTo: tweetId)
        .where(Fields.reactedByProfileId, isEqualTo: myProfileId)
        .where(Fields.reactionType, isEqualTo: ReactionTypes.like)
        .get();

    batch.delete(myLikeOnMyFeed.docs.first.reference);

    // remove from feed of my followers
    final myFollowersList =
        await _database.collections.followers.doc(myProfileId).toMap();

    if (myFollowersList != null) {
      myFollowersList.keys.forEach((myFollowerId) async {
        final removeFeedRef = await _database.collections.feed
            .where(Fields.tweetId, isEqualTo: tweetId)
            .where(Fields.reactionType, isEqualTo: ReactionTypes.like)
            .where(Fields.reactedByProfileId, isEqualTo: myProfileId)
            .get();

        batch.delete(removeFeedRef.docs.first.reference);
      });
    }

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
    var tweetRef = _database.collections.tweets.doc(tweetId);

    //up retweet
    int retweetCount = await _getRetweetCount(tweetRef);

    retweetCount++;

    batch.update(tweetRef, {Fields.retweetCount: retweetCount});

    // set a feed for myself
    var myFeedWithMyReaction = _database.collections.feed.doc();

    batch.set(myFeedWithMyReaction, {
      Fields.concernedProfileId: myProfileId,
      Fields.tweetId: tweetId,
      Fields.creatorTweetProfileId: ofProfileId,
      Fields.reactionType: ReactionTypes.retweet,
      Fields.profileName: myProfileName,
      Fields.reactedByProfileId: myProfileId,
      Fields.createdAt: createdAt,
    });

    // set feed for my followers
    final myFollowersList =
        await _database.collections.followers.doc(myProfileId).toMap();

    if (myFollowersList != null) {
      myFollowersList.keys.forEach((myFollowerId) {
        final newFeedRef = _database.collections.feed.doc();

        batch.set(newFeedRef, {
          Fields.concernedProfileId: myFollowerId,
          Fields.tweetId: tweetId,
          Fields.creatorTweetProfileId: ofProfileId,
          Fields.reactionType: ReactionTypes.retweet,
          Fields.profileName: myProfileName,
          Fields.reactedByProfileId: myProfileId,
          Fields.createdAt: createdAt,
        });
      });
    }

    await batch.commit();
  }
}
