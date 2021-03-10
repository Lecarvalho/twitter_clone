import 'package:twitter_clone/models/profile_model.dart';

import 'service_base.dart';
import 'service_provider_base.dart';

abstract class ProfileServiceBase extends ServiceBase {
  ProfileServiceBase(ServiceProviderBase provider) :super(provider);
  Future<ProfileModel> createProfile(String id, String name);
  Future<ProfileModel?> getProfile(String id);
  Future<ProfileModel> updateProfile(ProfileModel profile);
  Future<String> uploadAvatar(String selectedImagePath);
  Future<void> follow(String myProfileId, String toFollowUserId);
  Future<void> unfollow(String myProfileId, String toUnfollowUserId);
}
