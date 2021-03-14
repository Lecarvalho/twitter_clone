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

    //1. create tweet
    final newTweetDoc = _database.collections.tweets.doc();

    batch.set(newTweetDoc, map);

    //2. create feed for my followers
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
    final List<TweetModel> tweets = List.empty();

    final myOwnTweets = await _database.collections.tweets
        .where(Fields.profileId, isEqualTo: myProfileId)
        .limit(5)
        .toModelList<TweetModel>((data) => TweetModel.fromMap(data));

    if (myOwnTweets != null) {
      tweets.addAll(myOwnTweets);
    }

    final myFeedMapList = await _database.collections.feed
        .where(Fields.concernedProfileId, isEqualTo: myProfileId)
        .limit(20)
        .toMapList();

    if (myFeedMapList != null) {
      myFeedMapList.forEach((myFeedElement) async {
        final tweet = await _database.collections.tweets
            .doc(myFeedElement[Fields.tweetId])
            .toModel<TweetModel>((data) => TweetModel.fromMap(data));

        if (tweet != null) {
          final reactionType = myFeedElement[Fields.reactionType];
          if (reactionType != null) {
            // retweet or like
            tweet.tweetActivity = TweetActivityModel.fromMap(myFeedElement);
          }
          tweets.add(tweet);
        }
      });
    }

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
    // up likeCount

    final tweetRef = _database.collections.tweets.doc(tweetId);

    final tweetDoc = await tweetRef.get();

    int likeCount = tweetDoc.data()![Fields.likeCount] ?? 0;

    likeCount++;

    batch.update(tweetRef, {Fields.likeCount: likeCount});

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
    //up retweet
    var tweetRef = _database.collections.tweets.doc(tweetId);

    var tweetDoc = await tweetRef.get();

    int retweetCount = tweetDoc.data()![Fields.retweetCount] ?? 0;

    retweetCount++;

    batch.update(tweetRef, {Fields.retweetCount: retweetCount});

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
      });
    });

    await batch.commit();
  }
}
