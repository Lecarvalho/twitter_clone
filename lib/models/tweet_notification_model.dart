import 'model_base.dart';
import 'tweet_model.dart';

class TweetNotificationModel extends ModelBase {
  String id;
  String tweetId;
  TweetModel tweet;

  TweetNotificationModel({
    this.id,
    this.tweetId,
    this.tweet,
  });

  factory TweetNotificationModel.fromMap(Map<String, dynamic> data) {
    return TweetNotificationModel(
      id: data["id"],
      tweetId: data["tweetId"],
      tweet: TweetModel.fromMap(data["tweet"]),
    );
  }
}
