import 'package:twitter_clone/models/reply_model.dart';
import 'package:twitter_clone/services/reply_service_base.dart';

import 'controller_base.dart';

class ReplyController extends ControllerBase<ReplyServiceBase> {
  ReplyController({required service}) : super(service: service);

  List<ReplyModel>? _replies;
  List<ReplyModel>? get replies => _replies;

  Future<void> getReplies(String tweetId) async {
    try {
      _replies = await service.getReplies(tweetId);
    } catch (e) {
      print("Error on getReplies: " + e.toString());
    }
  }

  Future<void> replyTweet({
    required String replyingToTweetId,
    required String text,
    required String myProfileId,
    required String replyingToProfileId,
  }) async {
    try {
      await service.replyTweet(
        text: text,
        replyingToTweetId: replyingToTweetId,
        myProfileId: myProfileId,
        replyingToProfileId: replyingToProfileId,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      print("Error on replyTweet: " + e.toString());
    }
  }
}
