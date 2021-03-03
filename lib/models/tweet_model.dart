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
    this.didIHeartIt,
    this.didIRetweet,
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
  bool didIHeartIt;
  bool didIRetweet;

  bool canRetweet(String myProfileId) => !didIRetweet && profileId !=  myProfileId;

  factory TweetModel.fromMap(Map<String, dynamic> data) {
    return TweetModel(
      id: data["id"],
      profileId: data["profileId"],
      text: data["text"],
      creationDate: DateTime.parse(data["creationDate"]),
      heartCount: data["heartCount"] ?? 0,
      commentCount: data["commentCount"] ?? 0,
      retweetCount: data["retweetCount"] ?? 0,
      profile: ProfileModel.fromMapSingleTweet(data["profile"]),
      didIHeartIt: data["didIHeartIt"] ?? false,
      didIRetweet: data["didIRetweet"] ?? false,
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
