import 'package:twitter_clone/models/reply_model.dart';

import 'service_base.dart';

abstract class ReplyServiceBase extends ServiceBase {
  Future<List<ReplyModel>?> getReplies(String tweetId);

  Future<void> replyTweet({
    required String replyingToTweetId,
    required String text,
    required String myProfileId,
    required DateTime createdAt,
    required String replyingToProfileId,
  });
}
