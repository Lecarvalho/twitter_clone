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
    this.isHearted,
    this.isRetweeted,
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
  bool isHearted;
  bool isRetweeted;

  bool canRetweet(String myProfileId) => !isRetweeted && profileId !=  myProfileId;

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
      isHearted: data["isHearted"],
      isRetweeted: data["isRetweeted"],
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
