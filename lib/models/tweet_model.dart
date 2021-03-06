import 'as_tweet_model_base.dart';
import 'profile_model.dart';
import 'tweet_activity_model.dart';

class TweetModel extends AsTweetModelBase {
  TweetModel({
    required String id,
    required String profileId,
    required String text,
    required DateTime creationDate,
    required ProfileModel profile,
    required this.likeCount,
    required this.commentCount,
    required this.retweetCount,
    required this.didILike,
    required this.didIRetweet,
    required this.tweetActivity,
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
  TweetActivityModel? tweetActivity;

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
}
