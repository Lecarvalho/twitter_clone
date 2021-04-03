import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/services/providers/service_provider_base.dart';

import 'service_base.dart';

abstract class FeedServiceBase extends ServiceBase {
  FeedServiceBase(ServiceProviderBase provider) : super(provider);

  Stream<FeedUpdateResponse> listenFeed(String myProfileId);
  Stream<TweetModel> listenTweetChanges(String tweetId);
}

class FeedUpdateResponse {
  List<TweetModel> commingTweets;
  List<String>? deletedTweetsIds;
  FeedUpdateResponse({
    required this.commingTweets,
    this.deletedTweetsIds,
  });
}
