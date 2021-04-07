import 'dart:async';

import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/services/providers/service_provider_base.dart';

import '../feed_service_base.dart';
import 'mock_tools.dart';

class FeedServiceMock extends FeedServiceBase {
  FeedServiceMock(ServiceProviderBase provider) : super(provider);

  @override
  Future<StreamSubscription> streamFeed(
      String myProfileId, Function(FeedUpdateResponse) onListen) async {
    final tweets = await MockTools.jsonToModelList<TweetModel>(
      "assets/json/tweets.json",
      (Map<String, dynamic> data) => TweetModel.fromMap(data),
    );

    final tweetIds = tweets!.map((tweet) => tweet.id).toSet();

    return Stream.value(onListen(
      FeedUpdateResponse(
        commingTweets: {tweetIds.first: null},
        deletedTweetsIds: {},
      ),
    )).listen((event) {});
  }

  @override
  Future<StreamSubscription> streamTweet(String tweetId, String myProfileId,
      Function(TweetModel?) onListen) async {
    final tweets = await MockTools.jsonToModelList<TweetModel>(
      "assets/json/tweets.json",
      (Map<String, dynamic> data) => TweetModel.fromMap(data),
    );

    final tweet = tweets?.firstWhere((_tweet) => _tweet.id == tweetId);

    return Stream.value(onListen(tweet)).listen((event) {});
  }
}
