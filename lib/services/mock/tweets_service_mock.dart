import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/services/tweets_service_base.dart';

import 'json_tools.dart';

class TweetsServiceMock implements TweetsServiceBase {
  @override
  Future<List<TweetModel>> getTweets(String myProfileId) async {
    return await JsonTools.jsonToModelList<TweetModel>(
      "assets/json/tweets.json",
      (Map<String, dynamic> data) => TweetModel.fromMap(data),
    );
  }

  @override
  Future<List<TweetModel>> getProfileTweets(String profileId) async {
    return JsonTools.jsonToModelList<TweetModel>(
      "assets/json/profile_tweets.json",
      (Map<String, dynamic> data) => TweetModel.fromMap(data),
    );
  }

  @override
  Future<void> createTweet(TweetModel tweet) async {
    print("${tweet.text}");
    print("${tweet.profileId}");
    print("${tweet.creationDate.toString()}");
  }

  @override
  Future<TweetModel> getTweet(String tweetId) async {
    var tweets = await JsonTools.jsonToModelList<TweetModel>(
      "assets/json/tweets.json",
      (Map<String, dynamic> data) => TweetModel.fromMap(data),
    );

    return tweets.firstWhere((_tweet) => _tweet.id == tweetId);
  }

  @override
  Future<void> heartTweet(
      String tweetId, String ofProfileId, String myProfileId) async {
    print("heartTweet !");
    print("tweetId $tweetId");
    print("ofProfileId $ofProfileId");
    print("myProfileId $myProfileId");
  }

  @override
  Future<void> retweet(String tweetId, String ofProfileId, String myProfileId) async {
    print("retweet !");
    print("tweetId $tweetId");
    print("ofProfileId $ofProfileId");
    print("myProfileId $myProfileId");
  }

  @override
  Future<void> unheartTweet(
    String tweetId,
    String ofProfileId,
    String myProfileId,
  ) async {
    print("unheartTweet !");
    print("tweetId $tweetId");
    print("ofProfileId $ofProfileId");
    print("myProfileId $myProfileId");
  }
}
