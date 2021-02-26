import 'as_tweet_model_base.dart';
import 'user_model.dart';

class CommentModel extends AsTweetModelBase {
  CommentModel({
    id,
    text,
    userId,
    creationDate,
    userModel,
    this.tweetId,
    this.replyingUserId,
  }) : super(
          id: id,
          text: text,
          userId: userId,
          creationDate: creationDate,
          userModel: userModel,
        );

  String tweetId;
  String replyingUserId;

  factory CommentModel.fromMap(Map<String, dynamic> data) {
    return CommentModel(
      id: data["id"],
      userId: data["userId"],
      text: data["text"],
      creationDate: DateTime.parse(data["creationDate"]),
      tweetId: data["tweetId"],
      replyingUserId: data["replyingUserId"],
      userModel: UserModel.fromMapSingleTweet(data["user"]),
    );
  }

  factory CommentModel.toMap({
    String tweetId,
    String commentText,
    String myUserId,
  }) {
    return CommentModel(
      tweetId: tweetId,
      text: commentText,
      userId: myUserId,
    );
  }
}
