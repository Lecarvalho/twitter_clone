import 'package:intl/intl.dart';
import 'package:twitter_clone/models/model_base.dart';

class ProfileModel extends ModelBase {
  String id;
  String name;
  DateTime? createdAt;
  String? nickname;
  String? avatar;
  String? bio;
  int? followersCount;
  List<String>? following;

  ProfileModel({
    required this.id,
    required this.name,
    this.createdAt,
    this.nickname,
    this.avatar,
    this.bio,
    this.followersCount,
    this.following,
  });

  bool get isProfileComplete =>
      nickname != null && avatar != null && bio != null;

  int get followingCount => following?.length ?? 0;

  String get createdAtDateMonthYear =>
      DateFormat.MMMM().add_y().format(createdAt!);

  String get nicknameWithAt => "@$nickname";

  factory ProfileModel.fromCreation(Map<String, dynamic> data) {
    return ProfileModel(
      id: data["id"],
      name: data["name"],
      createdAt: DateTime.parse(data["createdAt"]),
    );
  }

  factory ProfileModel.fromFullInfo(Map<String, dynamic> data) {
    return ProfileModel(
      id: data["id"],
      name: data["name"],
      avatar: data["avatar"],
      nickname: data["nickname"],
      bio: data["bio"],
      createdAt: DateTime.parse(data["createdAt"]),
      followersCount: data["followersCount"] ?? 0,
      following: data["following"] != null
          ? List.from(data["following"])
          : List.empty(),
    );
  }

  factory ProfileModel.fromBasicInfo(Map<String, dynamic> data) {
    return ProfileModel(
      id: data["id"],
      name: data["name"],
      avatar: data["avatar"],
      nickname: data["nickname"],
    );
  }

  static Map<String, dynamic> getMapForUpdateProfile({
    required String nickname,
    required String avatar,
    required String bio,
  }) {
    return {
      "nickname": nickname,
      "avatar": avatar,
      "bio": bio,
    };
  }

  static Map<String, dynamic> getMapForCreateProfile({
    required String id,
    required String name,
    required DateTime createdAt,
  }) {
    return {
      "name": name,
      "createdAt": createdAt,
    };
  }

  static Map<String, dynamic> getMapForCreateTweet({
    required String id,
    required String avatar,
    required String name,
    required String nickname,
  }) {
    return {
      "id": id,
      "avatar": avatar,
      "name": name,
      "nickname": nickname,
    };
  }

  static String checkFields(
    String? newBio,
    String? newNickname,
    String? newAvatar,
  ) {
    if (newBio?.isEmpty ?? true) return "Please set a bio for your profile";

    if (newNickname?.isEmpty ?? true)
      return "Please set a nickname for your profile";

    if (newAvatar?.isEmpty ?? true)
      return "Please set a picture for your profile";

    return "Success";
  }
}
