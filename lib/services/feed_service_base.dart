import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/models/tweet_reaction_model.dart';
import 'package:twitter_clone/services/providers/service_provider_base.dart';

import 'service_base.dart';

abstract class FeedServiceBase extends ServiceBase {
  FeedServiceBase(ServiceProviderBase provider) : super(provider);

  Stream<FeedUpdateResponse> listenFeed(String myProfileId);
  Stream<TweetModel?> listenTweetChanges(String tweetId, String myProfileId);
}

class FeedUpdateResponse {
  Map<String, TweetReactionModel?> commingTweets;
  Set<String> deletedTweetsIds;
  FeedUpdateResponse({
    required this.commingTweets,
    required this.deletedTweetsIds,
  });
}
