import 'model_base.dart';
import 'package:twitter_clone/extensions/enum_extensions.dart';

class TweetActivityModel extends ModelBase {
  String profileName;
  TweetAction tweetAction;

  TweetActivityModel({
    required this.profileName,
    required this.tweetAction,
  });

  factory TweetActivityModel.fromMap(Map<String, dynamic> data){
    return TweetActivityModel(
      profileName: data["profileName"],
      tweetAction: data["reactionType"].toString().toEnum(TweetAction.values),
    );
  }
}

enum TweetAction { liked, retweeted }
