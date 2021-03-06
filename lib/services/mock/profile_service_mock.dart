import 'package:twitter_clone/models/profile_model.dart';

import '../profile_service_base.dart';
import 'mock_tools.dart';

class ProfileServiceMock implements ProfileServiceBase {
  @override
  Future<ProfileModel?> getProfile(String profileId) async {
    var profiles = await MockTools.jsonToModelList<ProfileModel>(
      "assets/json/profiles.json",
      (data) => ProfileModel.fromMapGetProfile(data),
    );

    await MockTools.simulateRequestDelay();

    return profiles?.firstWhere((profile) => profile.id == profileId);
  }

  @override
  Future<ProfileResponseType> createProfile({
    required String userId,
    required String bio,
    required String avatar,
    required DateTime inscriptionDate,
    required String name,
    required String nickname,
  }) async {
    print("name: $name");
    print("userId: $userId");
    print("avatar: $avatar");
    print("inscriptionDate: ${inscriptionDate.toString()}");
    print("bio: $bio");
    print("nickname: $nickname");

    await MockTools.simulateRequestDelay();

    return ProfileResponseType.success;
  }

  @override
  Future<String> uploadAvatar(String selectedImagePath) async {
    print("selectedImagePath: $selectedImagePath");

    await MockTools.simulateRequestDelay();

    //return new picture url
    return "https://static.wikia.nocookie.net/adventuretimewithfinnandjake/images/3/3b/Jakesalad.png/revision/latest/scale-to-width-down/340?cb=20190807133015";
  }

  @override
  Future<ProfileResponseType> updateProfile(ProfileModel myProfile) async {
    print("id: ${myProfile.id}");
    print("avatar: ${myProfile.avatar}");
    print("bio: ${myProfile.bio}");

    await MockTools.simulateQuickRequestDelay();
    
    return ProfileResponseType.success;
  }

  @override
  Future<void> follow(String myProfileId, String toFollowUserId) async {
    print("myProfileId $myProfileId");
    print("update followingCount +1");
    print("update toFollowUser followingCount +1");
    print("following $toFollowUserId");
    
    await MockTools.simulateQuickRequestDelay();
  }

  @override
  Future<void> unfollow(String myProfileId, String toUnfollowUserId) async {
    print("myProfileId $myProfileId");
    print("update followingCount -1");
    print("update toUnfollowUserId followingCount -1");
    print("Unfollowing $toUnfollowUserId");

    await MockTools.simulateQuickRequestDelay();
  }
}
