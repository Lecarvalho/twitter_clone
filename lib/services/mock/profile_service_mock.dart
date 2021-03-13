import 'package:twitter_clone/models/profile_model.dart';
import 'package:twitter_clone/services/mock/mock_tools.dart';

import '../profile_service_base.dart';
import 'service_provider_mock.dart';

class ProfileServiceMock extends ProfileServiceBase {
  ProfileServiceMock(ServiceProviderMock provider) : super(provider);

  @override
  Future<ProfileModel> createProfile(String id, Map<String, dynamic> profileMap)async {
    var profile = await MockTools.jsonToModel<ProfileModel>(
      "assets/json/incomplete_profile.json",
      (data) => ProfileModel.fromCreation(data),
    );

    return profile!;
  }

  @override
  Future<ProfileModel?> getProfile(String id) async {
    // return null; path 1: to create a new profile
    // return null;

    // return uncomplete; path 2: to redirect to complete profile page
    // return await MockTools.jsonToModel<ProfileModel2>(
    //   "assets/json/incomplete_profile.json",
    //   (data) => ProfileModel2.fromFullInfo(data),
    // );

    // return complete; to redirect to login (when on login screen)
    var profiles = await MockTools.jsonToModelList<ProfileModel>(
      "assets/json/profiles.json",
      (data) => ProfileModel.fromFullInfo(data),
    );

    if (profiles != null) {
      var profilesFound = profiles.where((profile) => profile.id == id);
      if (profilesFound.length == 0)
        return null;
      else
        return profilesFound.first;
    }
  }

  @override
  Future<ProfileModel> updateProfile(String id, Map<String, dynamic> profileMap) async {
    print("id: ${profileMap["id"]}");
    print("avatar: ${profileMap["avatar"]}");
    print("bio: ${profileMap["bio"]}");
    print("nickname: ${profileMap["nickname"]}");

    await MockTools.simulateQuickRequestDelay();

    return (await getProfile(id))!;
  }

  @override
  Future<String> uploadAvatar(String selectedImagePath, String filename) async {
    print("selectedImagePath: $selectedImagePath");

    await MockTools.simulateRequestDelay();

    //return new picture url
    return "https://static.wikia.nocookie.net/adventuretimewithfinnandjake/images/3/3b/Jakesalad.png/revision/latest/scale-to-width-down/340?cb=20190807133015";
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

  @override
  Future<bool> isNicknameAvailable(String nickname) async {
    return true;
  }
}
