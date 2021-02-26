import 'package:twitter_clone/models/tweet_model.dart';

import 'service_base.dart';

abstract class TweetsServiceBase extends ServiceBase {
  Future<List<TweetModel>> getTweets();

  Future<List<TweetModel>> getUserTweets(String userId);

  Future<void> createTweet(TweetModel tweetModel);

  Future<TweetModel> getTweet(String tweetId);
}
