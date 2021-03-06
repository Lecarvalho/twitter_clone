import 'package:twitter_clone/models/profile_model.dart';

import 'service_base.dart';

abstract class ProfileServiceBase extends ServiceBase {
  Future<ProfileModel?> getProfile(String profileId);
  Future<ProfileResponseType> createProfile({
    required String userId,
    required String bio,
    required String avatar,
    required DateTime inscriptionDate,
    required String name,
    required String nickname,
  });
  Future<ProfileResponseType> updateProfile(ProfileModel myProfile);
  Future<String> uploadAvatar(String selectedImagePath);
  Future<void> follow(String myProfileId, String toFollowUserId);
  Future<void> unfollow(String myProfileId, String toUnfollowUserId);
}

enum ProfileResponseType {
  invalid_information,
  success,
}
