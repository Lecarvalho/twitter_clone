import 'as_tweet_model_base.dart';
import 'profile_model.dart';
import 'tweet_activity_model.dart';

class TweetModel extends AsTweetModelBase {
  TweetModel({
    String id,
    String profileId,
    String text,
    DateTime creationDate,
    ProfileModel profile,
    this.likeCount,
    this.commentCount,
    this.retweetCount,
    this.didILike,
    this.didIRetweet,
    this.tweetActivity,
  }) : super(
          id: id,
          profileId: profileId,
          text: text,
          creationDate: creationDate,
          profile: profile,
        );

  int likeCount;
  int commentCount;
  int retweetCount;
  bool didILike;
  bool didIRetweet;
  TweetActivityModel tweetActivity;

  bool canRetweet(String myProfileId) =>
      !didIRetweet && profileId != myProfileId;

  factory TweetModel.fromMap(Map<String, dynamic> data) {
    return TweetModel(
      id: data["id"],
      profileId: data["profileId"],
      text: data["text"],
      creationDate: DateTime.parse(data["creationDate"]),
      likeCount: data["likeCount"] ?? 0,
      commentCount: data["commentCount"] ?? 0,
      retweetCount: data["retweetCount"] ?? 0,
      profile: ProfileModel.fromMapSingleTweet(data["profile"]),
      didILike: data["didILike"] ?? false,
      didIRetweet: data["didIRetweet"] ?? false,
      tweetActivity: data["activity"] != null
          ? TweetActivityModel.fromMap(data["activity"])
          : null,
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
