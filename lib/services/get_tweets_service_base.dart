import 'package:twitter_clone/models/tweet_model.dart';

abstract class GetTweetsServiceBase {
  Future<List<TweetModel>> getTweets();
}