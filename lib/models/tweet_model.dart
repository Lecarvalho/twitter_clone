import 'as_tweet_model_base.dart';
import 'profile_model.dart';

class TweetModel extends AsTweetModelBase {
  TweetModel({
    String id,
    String profileId,
    String text,
    DateTime creationDate,
    ProfileModel profile,
    this.heartCount,
    this.commentCount,
    this.retweetCount,
  }) : super(
          id: id,
          profileId: profileId,
          text: text,
          creationDate: creationDate,
          profile: profile,
        );

  int heartCount;
  int commentCount;
  int retweetCount;

  factory TweetModel.fromMap(Map<String, dynamic> data) {
    return TweetModel(
      id: data["id"],
      profileId: data["profileId"],
      text: data["text"],
      creationDate: DateTime.parse(data["creationDate"]),
      heartCount: data["heartCount"],
      commentCount: data["commentCount"],
      retweetCount: data["retweetCount"],
      profile: ProfileModel.fromMapSingleTweet(data["profile"]),
    );
  }

  factory TweetModel.toMap({
    String profileId,
    String text,
    DateTime creationDate,
  }) {
    return TweetModel(
      profileId: profileId,
      text: text,
      creationDate: creationDate,
    );
  }
}
