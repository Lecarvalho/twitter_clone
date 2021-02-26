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
    this.replyingToUserId,
  }) : super(
          id: id,
          text: text,
          userId: userId,
          creationDate: creationDate,
          userModel: userModel,
        );

  String tweetId;
  String replyingToUserId;

  factory CommentModel.fromMap(Map<String, dynamic> data) {
    return CommentModel(
      id: data["id"],
      userId: data["userId"],
      text: data["text"],
      creationDate: DateTime.parse(data["creationDate"]),
      tweetId: data["tweetId"],
      replyingToUserId: data["replyingToUserId"],
      userModel: UserModel.fromMapSingleTweet(data["user"]),
    );
  }
}
