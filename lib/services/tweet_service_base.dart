import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/services/providers/service_provider_base.dart';

import 'service_base.dart';

abstract class TweetServiceBase extends ServiceBase {
  TweetServiceBase(ServiceProviderBase provider) : super(provider);

  Future<List<TweetModel>?> getTweets(String myProfileId);

  Future<List<TweetModel>?> getProfileTweets(
    String profileId,
    String myProfileId,
  );

  Future<void> createTweet(Map<String, dynamic> map);

  Future<TweetModel?> getTweet(String tweetId, String myProfileId);

  Future<void> likeTweet(
    String tweetId,
    String ofProfileId,
    String myProfileId,
    String myProfileName,
  );

  Future<void> unlikeTweet(
    String tweetId,
    String ofProfileId,
    String myProfileId,
  );

  Future<void> retweet(
    String tweetId,
    String ofProfileId,
    String myProfileId,
    String myProfileName,
  );
}
