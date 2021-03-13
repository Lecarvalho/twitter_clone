import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitter_clone/config/app_config.dart';
import 'package:twitter_clone/models/tweet_model.dart';

import 'providers/database_provider.dart';
import 'tweets_service_base.dart';

class TweetsService extends TweetsServiceBase {
  late DatabaseProvider _database;

  TweetsService(DatabaseProvider provider) : super(provider) {
    _database = provider;
  }

  @override
  Future<void> createTweet(Map<String, dynamic> map) async {
    await _database.collections.tweets.add(map);
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
    final List<TweetModel>? tweets;

    final myFollowingList =
        await _database.collections.followingList.doc(myProfileId).toMap();

    if (myFollowingList == null) return null;

    final sortedDates = myFollowingList.values.toList()
      ..sort(
        (a, b) => myFollowingList[b].compareTo(myFollowingList[a]),
      );

    final myFollowingListOrdered = LinkedHashMap.fromIterable(
      sortedDates,
      key: (k) => k,
      value: (k) => sortedDates[k],
    );

    tweets = List<TweetModel>.empty();

    for (int i = 0;
        myFollowingListOrdered.length <=
            AppConfig.maxTweetsHome / TypeOfTweets.values.length;
        i++) {
      final whoImFollowingProfileId = myFollowingList[Fields.profileId];

      // tweetFromWhoImFollowing
      tweets.addAll(
        await _database.collections.tweets
            .where(Fields.profileId, isEqualTo: whoImFollowingProfileId)
            .limit(1)
            .toModelList((data) => TweetModel.fromMap(data)),
      );

      // retweetBySomeoneImFollowing
      var retweet = await _getOneLikeOrRetweetFromMyFollowing(
          whoImFollowingProfileId, TypeOfTweets.retweetBySomeoneImFollowing);

      if (retweet != null) {
        tweets.add(retweet);
      }

      // likedBySomeoneImFollowing
      var liked = await _getOneLikeOrRetweetFromMyFollowing(
          whoImFollowingProfileId, TypeOfTweets.likedBySomeoneImFollowing);

      if (liked != null) {
        tweets.add(liked);
      }
    }

    return tweets;
  }

  Future<TweetModel?> _getOneLikeOrRetweetFromMyFollowing(
    String whoImFollowingProfileId,
    TypeOfTweets typeOfTweet,
  ) async {
    CollectionReference reactionTweetCollection;

    if (typeOfTweet == TypeOfTweets.retweetBySomeoneImFollowing) {
      reactionTweetCollection = _database.collections.retweets;
    } else {
      reactionTweetCollection = _database.collections.likes;
    }

    final reactionTweetMap =
        await reactionTweetCollection.doc(whoImFollowingProfileId).toMap();

    if (reactionTweetMap == null) return null;

    final tweetId = reactionTweetMap.entries.first.key;

    final tweetRetweeted = await _database.collections.tweets
        .doc(tweetId)
        .toModel<TweetModel>((data) => TweetModel.fromMap(data));

    return tweetRetweeted;
  }

  @override
  Future<void> likeTweet(
    String tweetId,
    String ofProfileId,
    String myProfileId,
  ) async {
    // up likeCount

    var tweetRef = _database.collections.tweets.doc(tweetId);

    var tweetDoc = await tweetRef.get();

    int likeCount = tweetDoc.data()![Fields.likeCount] ?? 0;

    likeCount++;

    await tweetRef.update({
      Fields.likeCount: likeCount,
    });

    // create like ref

    var likesProfilesRef = _database.collections.likes
        .doc(tweetId)
        .collection("profiles")
        .doc(myProfileId);

    var likesSnapshot = await likesProfilesRef.toSnapshot();

    if (likesSnapshot.exists) {
      await likesProfilesRef.update({Fields.profileId: myProfileId});
    } else {
      await likesProfilesRef.set({Fields.profileId: myProfileId});
    }
  }

  @override
  Future<void> unlikeTweet(
    String tweetId,
    String ofProfileId,
    String myProfileId,
  ) async {
    // down likeCount

    var tweetRef = _database.collections.tweets.doc(tweetId);

    var tweetDoc = await tweetRef.get();

    int likeCount = tweetDoc.data()![Fields.likeCount];

    likeCount--;

    await tweetRef.update({
      Fields.likeCount: likeCount,
    });

    // remove like ref

    await _database.collections.likes
        .doc(tweetId)
        .collection("profiles")
        .doc(myProfileId)
        .delete();
  }

  @override
  Future<void> retweet(
    String tweetId,
    String ofProfileId,
    String myProfileId,
  ) async {
    //up retweet
    var tweetRef = _database.collections.tweets.doc(tweetId);

    var tweetDoc = await tweetRef.get();

    int retweetCount = tweetDoc.data()![Fields.retweetCount] ?? 0;

    retweetCount++;

    await tweetRef.update({
      Fields.retweetCount: retweetCount,
    });

    //create retweet ref
    var retweetsProfilesRef = _database.collections.retweets
        .doc(tweetId)
        .collection("profiles")
        .doc(myProfileId);

    var retweetsSnapshot = await retweetsProfilesRef.toSnapshot();

    if (retweetsSnapshot.exists) {
      await retweetsProfilesRef.update({Fields.profileId: myProfileId});
    } else {
      await retweetsProfilesRef.set({Fields.profileId: myProfileId});
    }
  }
}

enum TypeOfTweets {
  tweetFromWhoImFollowing,
  retweetBySomeoneImFollowing,
  likedBySomeoneImFollowing,
}
