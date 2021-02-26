import 'package:flutter/foundation.dart';
import 'package:twitter_clone/models/comment_model.dart';
import 'package:twitter_clone/services/comment_service_base.dart';

import 'controller_base.dart';

class CommentController extends ControllerBase<CommentServiceBase> {
  CommentController({@required service}) : super(service: service);

  List<CommentModel> _comments;
  List<CommentModel> get comments => _comments;

  Future<void> getComments(String tweetId) async {
    try {
      _comments = await service.getComments(tweetId);
    } catch (e) {
      print("Error on getComments: " + e);
    }
  }

  Future<void> commentTweet({
    String tweetId,
    String commentText,
    String myUserId,
  }) async {
    try {
      var comment = CommentModel.toMap(
        tweetId: tweetId,
        commentText: commentText,
        myUserId: myUserId,
      );
      await service.commentTweet(comment);
    } catch (e) {
      print("Error on commentTweet: " + e);
    }
  }
}
