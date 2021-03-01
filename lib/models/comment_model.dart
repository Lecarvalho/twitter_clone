import 'as_tweet_model_base.dart';
import 'profile_model.dart';

class CommentModel extends AsTweetModelBase {
  CommentModel({
    String id,
    String text,
    String profileId,
    DateTime creationDate,
    ProfileModel profile,
    this.tweetId,
    this.replyingProfileId,
  }) : super(
          id: id,
          text: text,
          profileId: profileId,
          creationDate: creationDate,
          profile: profile,
        );

  String tweetId;
  String replyingProfileId;

  factory CommentModel.fromMap(Map<String, dynamic> data) {
    return CommentModel(
      id: data["id"],
      profileId: data["profileId"],
      text: data["text"],
      creationDate: DateTime.parse(data["creationDate"]),
      tweetId: data["tweetId"],
      replyingProfileId: data["replyingProfileId"],
      profile: ProfileModel.fromMapSingleTweet(data["profile"]),
    );
  }

  factory CommentModel.toMap({
    String tweetId,
    String commentText,
    String myProfileId,
  }) {
    return CommentModel(
      tweetId: tweetId,
      text: commentText,
      profileId: myProfileId,
    );
  }
}
