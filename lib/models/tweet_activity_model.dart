import 'model_base.dart';
import 'extensions.dart';

class TweetActivityModel extends ModelBase {
  String profileName;
  TweetAction tweetAction;

  TweetActivityModel({
    this.profileName,
    this.tweetAction,
  });

  factory TweetActivityModel.fromMap(Map<String, dynamic> data){
    return TweetActivityModel(
      profileName: data["profileName"],
      tweetAction: data["action"].toString().toEnum(TweetAction.values),
    );
  }
}

enum TweetAction { liked, retweeted }
