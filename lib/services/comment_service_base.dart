import 'package:twitter_clone/models/comment_model.dart';

import 'service_base.dart';

abstract class CommentServiceBase extends ServiceBase {
  Future<List<CommentModel>> getComments(String tweetId);
}