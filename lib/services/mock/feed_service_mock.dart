import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/services/providers/service_provider_base.dart';

import '../feed_service_base.dart';
import 'mock_tools.dart';

class FeedServiceMock extends FeedServiceBase {
  FeedServiceMock(ServiceProviderBase provider) : super(provider);

  @override
  Stream<FeedUpdateResponse> listenFeed(String myProfileId) async* {
    final tweets = await MockTools.jsonToModelList<TweetModel>(
      "assets/json/tweets.json",
      (Map<String, dynamic> data) => TweetModel.fromMap(data),
    );

    yield FeedUpdateResponse(commingTweets: tweets!);
  }

  @override
  Stream<TweetModel> listenTweetChanges(String tweetId) async* {
    final tweets = await MockTools.jsonToModelList<TweetModel>(
      "assets/json/tweets.json",
      (Map<String, dynamic> data) => TweetModel.fromMap(data),
    );

    yield tweets!.firstWhere((_tweet) => _tweet.id == tweetId);
  }
  
}