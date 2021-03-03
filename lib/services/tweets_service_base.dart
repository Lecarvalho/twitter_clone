import 'package:twitter_clone/models/tweet_model.dart';

import 'service_base.dart';

abstract class TweetsServiceBase extends ServiceBase {
  Future<List<TweetModel>> getTweets(String myProfileId);

  Future<List<TweetModel>> getProfileTweets(String profileId);

  Future<void> createTweet(TweetModel tweet);

  Future<TweetModel> getTweet(String tweetId);

  Future<void> likeTweet(String tweetId, String ofProfileId, String myProfileId);

  Future<void> unlikeTweet(String tweetId, String ofProfileId, String myProfileId);

  Future<void> retweet(String tweetId, String ofProfileId, String myProfileId);
}
