import 'package:twitter_clone/models/reply_model.dart';

import '../reply_service_base.dart';
import 'mock_tools.dart';

class ReplyServiceMock implements ReplyServiceBase {
  @override
  Future<List<ReplyModel>?> getReplies(String tweetId) async {
    var replies = await MockTools.jsonToModelList<ReplyModel>(
      "assets/json/replies.json",
      (Map<String, dynamic> data) => ReplyModel.fromMap(data),
    );

    await MockTools.simulateRequestDelay();

    return replies?.where((reply) => reply.replyingToTweetId == tweetId).toList();
  }

  @override
  Future<void> replyTweet({
    required String replyingToTweetId,
    required String text,
    required String myProfileId,
    required DateTime createdAt,
    required String replyingToProfileId,
  }) async {
    print("replyingToTweetId: $replyingToTweetId");
    print("text: $text");
    print("myProfileId: $myProfileId");

    await MockTools.simulateQuickRequestDelay();
  }
}
