import 'model_base.dart';
import 'package:twitter_clone/extensions/enum_extensions.dart';

class TweetReactionModel extends ModelBase {
  String reactedByProfileName;
  String reactedByProfileId;
  TweetReactionType reactionType;

  TweetReactionModel({
    required this.reactedByProfileName,
    required this.reactedByProfileId,
    required this.reactionType,
  });

  factory TweetReactionModel.fromMap(Map<String, dynamic> data){
    return TweetReactionModel(
      reactedByProfileName: data["reactedByProfileName"],
      reactedByProfileId: data["reactedByProfileId"],
      reactionType: data["reactionType"].toString().toEnum(TweetReactionType.values),
    );
  }
}

enum TweetReactionType { like, retweet }
