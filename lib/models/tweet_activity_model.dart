import 'model_base.dart';
import 'package:twitter_clone/extensions/enum_extensions.dart';

class TweetActivityModel extends ModelBase {
  String profileName;
  String reactedByProfileId;
  TweetAction tweetAction;

  TweetActivityModel({
    required this.profileName,
    required this.reactedByProfileId,
    required this.tweetAction,
  });

  factory TweetActivityModel.fromMap(Map<String, dynamic> data){
    return TweetActivityModel(
      profileName: data["profileName"],
      reactedByProfileId: data["reactedByProfileId"],
      tweetAction: data["reactionType"].toString().toEnum(TweetAction.values),
    );
  }
}

enum TweetAction { like, retweet }
