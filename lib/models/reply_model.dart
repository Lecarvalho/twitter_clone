import 'as_tweet_model_base.dart';
import 'profile_model.dart';

class ReplyModel extends AsTweetModelBase {
  ReplyModel({
    required String text,
    required String profileId,
    required DateTime createdAt,
    required ProfileModel profile,
    required this.id,
    required this.replyingToTweetId,
    required this.replyingToProfileId,
  }) : super(
          id: id,
          text: text,
          profileId: profileId,
          createdAt: createdAt,
          profile: profile,
        );

  String id;
  String replyingToTweetId;
  String replyingToProfileId;

  factory ReplyModel.fromMap(Map<String, dynamic> data) {
    return ReplyModel(
      id: data["id"],
      profileId: data["profileId"],
      text: data["text"],
      createdAt: DateTime.parse(data["createdAt"]),
      profile: ProfileModel.fromMapSingleTweet(data["profile"]),
      replyingToProfileId: data["replyingToProfileId"],
      replyingToTweetId: data["replyingToTweetId"],
    );
  }
}
