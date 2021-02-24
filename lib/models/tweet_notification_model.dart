import 'model_base.dart';
import 'tweet_model.dart';

class TweetNotificationModel extends ModelBase {
  String id;
  String tweetId;
  TweetModel tweetModel;

  TweetNotificationModel({
    this.id,
    this.tweetId,
    this.tweetModel,
  });

  factory TweetNotificationModel.fromMap(Map<String, dynamic> data) {
    return TweetNotificationModel(
      id: data["id"],
      tweetId: data["tweetId"],
      tweetModel: TweetModel.fromMap(data["tweet"]),
    );
  }
}
