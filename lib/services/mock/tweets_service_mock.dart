import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/services/tweets_service_base.dart';

import 'mock_tools.dart';

class TweetsServiceMock implements TweetsServiceBase {
  @override
  Future<List<TweetModel>?> getTweets(String myProfileId) async {

    await MockTools.simulateRequestDelay();

    return await MockTools.jsonToModelList<TweetModel>(
      "assets/json/tweets.json",
      (Map<String, dynamic> data) => TweetModel.fromMap(data),
    );
  }

  @override
  Future<List<TweetModel>?> getProfileTweets(String profileId) async {
    await MockTools.simulateRequestDelay();

    return MockTools.jsonToModelList<TweetModel>(
      "assets/json/profile_tweets.json",
      (Map<String, dynamic> data) => TweetModel.fromMap(data),
    );
  }

  @override
  Future<void> createTweet({
    required String text,
    required String myProfileId,
    required DateTime createdAt,
  }) async {
    print("$text");
    print("$myProfileId");
    print("${createdAt.toString()}");

    await MockTools.simulateQuickRequestDelay();
  }

  @override
  Future<TweetModel?> getTweet(String tweetId) async {
    var tweets = await MockTools.jsonToModelList<TweetModel>(
      "assets/json/tweets.json",
      (Map<String, dynamic> data) => TweetModel.fromMap(data),
    );

    await MockTools.simulateRequestDelay();

    return tweets?.firstWhere((_tweet) => _tweet.id == tweetId);
  }

  @override
  Future<void> likeTweet(
      String tweetId, String ofProfileId, String myProfileId) async {
    print("likeTweet !");
    print("tweetId $tweetId");
    print("ofProfileId $ofProfileId");
    print("myProfileId $myProfileId");

    await MockTools.simulateQuickRequestDelay();
  }

  @override
  Future<void> retweet(String tweetId, String ofProfileId, String myProfileId) async {
    print("retweet !");
    print("tweetId $tweetId");
    print("ofProfileId $ofProfileId");
    print("myProfileId $myProfileId");

    await MockTools.simulateQuickRequestDelay();
  
  }

  @override
  Future<void> unlikeTweet(
    String tweetId,
    String ofProfileId,
    String myProfileId,
  ) async {
    print("unlikeTweet !");
    print("tweetId $tweetId");
    print("ofProfileId $ofProfileId");
    print("myProfileId $myProfileId");
    
    await MockTools.simulateQuickRequestDelay();
  }
}
