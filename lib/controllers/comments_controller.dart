import 'package:twitter_clone/models/comment_model.dart';
import 'package:twitter_clone/models/profile_model.dart';
import 'package:twitter_clone/services/comment_service_base.dart';

import 'controller_base.dart';

class CommentController extends ControllerBase<CommentServiceBase> {
  CommentController({required service}) : super(service: service);

  List<CommentModel>? _comments;
  List<CommentModel>? get comments => _comments;

  Future<void> getComments(String tweetId) async {
    try {
      _comments = await service.getComments(tweetId);
    } catch (e) {
      print("Error on getComments: " + e.toString());
    }
  }

  Future<void> commentTweet({
    required String tweetId,
    required String commentText,
    required ProfileModel myProfile,
    required String replyingToProfileId,
  }) async {
    try {
      var comment = CommentModel.toCreateComment(
        tweetId: tweetId,
        text: commentText,
        creationDate: DateTime.now(),
        profile: myProfile,
        profileId: myProfile.id,
        replyingToProfileId: replyingToProfileId,
      );
      await service.commentTweet(comment);
    } catch (e) {
      print("Error on commentTweet: " + e.toString());
    }
  }
}
