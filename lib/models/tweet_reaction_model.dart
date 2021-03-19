import 'model_base.dart';
import 'package:twitter_clone/extensions/enum_extensions.dart';

class TweetReactionModel extends ModelBase {
  String profileName;
  String reactedByProfileId;
  TweetReactionType reactionType;

  TweetReactionModel({
    required this.profileName,
    required this.reactedByProfileId,
    required this.reactionType,
  });

  factory TweetReactionModel.fromMap(Map<String, dynamic> data){
    return TweetReactionModel(
      profileName: data["profileName"],
      reactedByProfileId: data["reactedByProfileId"],
      reactionType: data["reactionType"].toString().toEnum(TweetReactionType.values),
    );
  }
}

enum TweetReactionType { like, retweet }
