import 'package:twitter_clone/models/comment_model.dart';

import '../comment_service_base.dart';
import 'json_tools.dart';

class CommentServiceMock implements CommentServiceBase {
  @override
  Future<List<CommentModel>> getComments(String tweetId) async {
    var comments = await JsonTools.jsonToModelList<CommentModel>(
      "assets/json/comments.json",
      (Map<String, dynamic> data) => CommentModel.fromMap(data),
    );

    return comments.where((comment) => comment.tweetId == tweetId).toList();
  }
}
