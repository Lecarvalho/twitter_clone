import 'package:twitter_clone/models/tweet_model.dart';

import 'service_base.dart';

abstract class TweetsServiceBase extends ServiceBase {
  Future<List<TweetModel>> getTweets();

  Future<List<TweetModel>> getProfileTweets(String profileId);

  Future<void> createTweet(TweetModel tweet);

  Future<TweetModel> getTweet(String tweetId);
}
