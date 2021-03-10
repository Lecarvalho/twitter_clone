import 'package:twitter_clone/models/reply_model.dart';
import 'package:twitter_clone/services/service_provider_base.dart';

import 'service_base.dart';

abstract class ReplyServiceBase extends ServiceBase {
  ReplyServiceBase(ServiceProviderBase provider) : super(provider);

  Future<List<ReplyModel>?> getReplies(String tweetId);

  Future<void> replyTweet({
    required String replyingToTweetId,
    required String text,
    required String myProfileId,
    required DateTime createdAt,
    required String replyingToProfileId,
  });
}
