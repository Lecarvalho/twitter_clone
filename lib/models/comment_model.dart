import 'as_tweet_model_base.dart';
import 'profile_model.dart';

class CommentModel extends AsTweetModelBase {
  CommentModel({
    required String text,
    required String profileId,
    required DateTime creationDate,
    required ProfileModel profile,
    required this.tweetId,
    required this.replyingToProfileId,
  }) : super(
          id: tweetId,
          text: text,
          profileId: profileId,
          creationDate: creationDate,
          profile: profile,
        );

  String tweetId;
  String replyingToProfileId;

  factory CommentModel.fromMap(Map<String, dynamic> data) {
    var comment = CommentModel(
      profileId: data["profileId"],
      text: data["text"],
      creationDate: DateTime.parse(data["creationDate"]),
      tweetId: data["tweetId"],
      replyingToProfileId: data["replyingToProfileId"],
      profile: ProfileModel.fromMapSingleTweet(data["profile"]),
    );

    comment.id = data["id"];

    return comment;
  }

  factory CommentModel.toCreateComment({
    required text,
    required profileId,
    required creationDate,
    required profile,
    required tweetId,
    required replyingToProfileId,
  }){
    return CommentModel(
      text: text,
      profileId: profileId,
      creationDate: creationDate,
      profile: profile,
      tweetId: tweetId,
      replyingToProfileId: replyingToProfileId,
    );
  }

  // factory CommentModel.toMap({
  //   required String tweetId,
  //   required String commentText,
  //   required String myProfileId,
  // }) {
  //   return CommentModel(
  //     tweetId: tweetId,
  //     text: commentText,
  //     profileId: myProfileId,
  //   );
  // }
}
