import 'as_tweet_model_base.dart';
import 'user_model.dart';

class TweetModel extends AsTweetModelBase {
  TweetModel({
    id,
    userId,
    text,
    creationDate,
    userModel,
    this.heartCount,
    this.commentCount,
    this.retweetCount,
  }) : super(
          id: id,
          userId: userId,
          text: text,
          creationDate: creationDate,
          userModel: userModel,
        );

  
  int heartCount;
  int commentCount;
  int retweetCount;

  factory TweetModel.fromMap(Map<String, dynamic> data) {
    return TweetModel(
      id: data["id"],
      userId: data["userId"],
      text: data["text"],
      creationDate: DateTime.parse(data["creationDate"]),
      heartCount: data["heartCount"],
      commentCount: data["commentCount"],
      retweetCount: data["retweetCount"],
      userModel: UserModel.fromMapSingleTweet(data["user"]),
    );
  }

  factory TweetModel.toMap(
      {String userId, String text, DateTime creationDate}) {
    return TweetModel(
      userId: userId,
      text: text,
      creationDate: creationDate,
    );
  }
}
