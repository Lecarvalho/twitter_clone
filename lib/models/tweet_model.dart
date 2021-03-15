import 'as_tweet_model_base.dart';
import 'profile_model.dart';
import 'tweet_activity_model.dart';

class TweetModel extends AsTweetModelBase {
  TweetModel({
    required String id,
    required String profileId,
    required String text,
    required DateTime createdAt,
    required ProfileModel profile,
    required this.likeCount,
    required this.repliesCount,
    required this.retweetCount,
    required this.didILike,
    required this.didIRetweet,
    required this.tweetActivity,
  }) : super(
          id: id,
          profileId: profileId,
          text: text,
          createdAt: createdAt,
          profile: profile,
        );

  int likeCount;
  int repliesCount;
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
      createdAt: DateTime.parse(data["createdAt"]),
      likeCount: data["likeCount"] ?? 0,
      repliesCount: data["repliesCount"] ?? 0,
      retweetCount: data["retweetCount"] ?? 0,
      profile: ProfileModel.fromBasicInfo(data["profile"]),
      didILike: data["didILike"] ?? false,
      didIRetweet: data["didIRetweet"] ?? false,
      tweetActivity: data["activity"] != null
          ? TweetActivityModel.fromMap(data["activity"])
          : null,
    );
  }

  static Map<String, dynamic> getMapForCreateTweet({
    required String text,
    required DateTime createdAt,
    required ProfileModel myProfile,
  }) {
    return {
      "text": text,
      "profileId": myProfile.id,
      "createdAt": createdAt,
      "profile": ProfileModel.getMapForCreateTweet(
        id: myProfile.id,
        avatar: myProfile.avatar!,
        name: myProfile.name,
        nickname: myProfile.nickname!,
      )
    };
  }
}
