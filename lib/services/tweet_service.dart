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
  Future<List<TweetModel>?> getProfileTweets(String profileId) async {
    return await _database.collections.tweets
        .where(Fields.profileId, isEqualTo: profileId)
        .toModelList((data) => TweetModel.fromMap(data));
  }

  @override
  Future<TweetModel?> getTweet(String tweetId) async {
    return await _database.collections.tweets
        .doc(tweetId)
        .toModel((data) => TweetModel.fromMap(data));
  }

  @override
  Future<List<TweetModel>?> getTweets(String myProfileId) async {
    List<TweetModel> tweets = [];

    // final myOwnTweets = await _database.collections.tweets
    //     .where(Fields.profileId, isEqualTo: myProfileId)
    //     .limit(5)
    //     .toModelList<TweetModel>((data) => TweetModel.fromMap(data));

    // if (myOwnTweets.isNotEmpty) {
    //   tweets.addAll(myOwnTweets);
    // }

    final myFeedMapList = await _database.collections.feed
        .where(Fields.concernedProfileId, isEqualTo: myProfileId)
        .limit(20)
        .orderBy(
          Fields.createdAt,
          descending: true,
        )
        .toMapList();

    if (myFeedMapList.isNotEmpty) {
      for (var myFeedMap in myFeedMapList) {
        final tweet = await _database.collections.tweets
            .doc(myFeedMap[Fields.tweetId])
            .toModel<TweetModel>((data) => TweetModel.fromMap(data));

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

    var uniqueIds = tweets.map((tweet) => tweet.id).toSet();

    tweets.retainWhere((tweet) => uniqueIds.remove(tweet.id));

    return tweets.length == 0 ? null : tweets;
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
    // up likeCount

    final tweetRef = _database.collections.tweets.doc(tweetId);

    final tweetMap = await tweetRef.toMap();

    int likeCount = tweetMap![Fields.likeCount] ?? 0;

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

    if (myFollowersList == null) return;

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

    await batch.commit();
  }

  @override
  Future<void> unlikeTweet(
    String tweetId,
    String ofProfileId,
    String myProfileId,
  ) async {
    final batch = _database.firestore.batch();
    // down likeCount

    var tweetRef = _database.collections.tweets.doc(tweetId);

    var tweetDoc = await tweetRef.get();

    int likeCount = tweetDoc.data()![Fields.likeCount];

    likeCount--;

    batch.update(tweetRef, {Fields.likeCount: likeCount});

    // remove from feed of my followers

    final myFollowersList =
        await _database.collections.followers.doc(myProfileId).toMap();

    if (myFollowersList == null) return;

    myFollowersList.keys.forEach((myFollowerId) async {
      final removeFeedRef = await _database.collections.feed
          .where(Fields.tweetId, isEqualTo: tweetId)
          .where(Fields.reactionType, isEqualTo: ReactionTypes.like)
          .where(Fields.reactedByProfileId, isEqualTo: myProfileId)
          .get();

      batch.delete(removeFeedRef.docs.first.reference);
    });

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
    //up retweet
    var tweetRef = _database.collections.tweets.doc(tweetId);

    var tweetDoc = await tweetRef.get();

    int retweetCount = tweetDoc.data()![Fields.retweetCount] ?? 0;

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

    if (myFollowersList == null) return;

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

    await batch.commit();
  }
}
