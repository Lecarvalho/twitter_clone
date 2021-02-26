import 'package:flutter/foundation.dart';
import 'package:twitter_clone/models/comment_model.dart';
import 'package:twitter_clone/services/comment_service_base.dart';

import 'controller_base.dart';

class CommentController extends ControllerBase<CommentServiceBase> {
  CommentController({@required service}) : super(service: service);

  List<CommentModel> _comments;
  List<CommentModel> get comments => _comments;

  Future<void> getComments(String tweetId) async {
    _comments = await service.getComments(tweetId);
  }
}