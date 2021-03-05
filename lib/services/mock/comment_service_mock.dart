import 'package:twitter_clone/models/comment_model.dart';

import '../comment_service_base.dart';
import 'mock_tools.dart';

class CommentServiceMock implements CommentServiceBase {
  @override
  Future<List<CommentModel>> getComments(String tweetId) async {
    var comments = await MockTools.jsonToModelList<CommentModel>(
      "assets/json/comments.json",
      (Map<String, dynamic> data) => CommentModel.fromMap(data),
    );

    await MockTools.simulateRequestDelay();

    return comments.where((comment) => comment.tweetId == tweetId).toList();
  }

  @override
  Future<void> commentTweet(CommentModel commentModel) async {
    print("tweetId: ${commentModel.tweetId}");
    print("text: ${commentModel.text}");
    print("myProfileId: ${commentModel.profileId}");

    await MockTools.simulateQuickRequestDelay();
  }
}
