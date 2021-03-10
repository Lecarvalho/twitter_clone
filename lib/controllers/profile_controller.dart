import 'package:twitter_clone/controllers/controller_base.dart';
import 'package:twitter_clone/models/profile_model.dart';
import 'package:twitter_clone/services/pick_image_service.dart';
import 'package:twitter_clone/services/profile_service_base.dart';

class ProfileController extends ControllerBase<ProfileServiceBase> {
  ProfileController({required service}) : super(service: service);

  ProfileModel? get profile => _profile;
  ProfileModel? _profile;

  late ProfileModel _myProfile;
  ProfileModel get myProfile => _myProfile;

  Future<void> getProfile(String profileId) async {
    try {
      _profile = await service.getProfile(profileId);
    } catch (e) {
      print("Error on getProfile: ${e.toString()}");
    }
  }

  set setMyProfile(ProfileModel myProfile) => _myProfile = myProfile;

  Future<void> follow(String toFollowUserId) async {
    try {
      _myProfile.following?.add(toFollowUserId);
      service.follow(_myProfile.id, toFollowUserId);
    } catch (e) {
      print("Error on follow: ${e.toString()}");
    }
  }

  Future<void> unfollow(String toUnfollowUserId) async {
    try {
      _myProfile.following?.remove(toUnfollowUserId);
      service.unfollow(_myProfile.id, toUnfollowUserId);
    } catch (e) {
      print("Error on unfollow: ${e.toString()}");
    }
  }

  Future<String?> selectAvatar() async {
    var pickImageService = PickImageService();

    var imagePath = await pickImageService.pickImagePath();
    return imagePath;
  }

  Future<String> resizeAvatar() async {
    // call an api to resize avatar
    throw UnimplementedError();
  }

  Future<String> updateProfile({
    required String bio,
    required String nickname,
    String? avatarLocalPath,
  }) async {
    try {
      var msgValidation = ProfileModel.checkFields(
        bio,
        nickname,
        avatarLocalPath ?? _myProfile.avatar,
      );

      if (msgValidation != "Success") {
        return msgValidation;
      }

      var hasChangePicture = avatarLocalPath?.isNotEmpty ?? false;

      if (hasChangePicture) {
        var avatarUrl = await service.uploadAvatar(avatarLocalPath!);

        _myProfile.avatar = avatarUrl;
      }

      _myProfile.bio = bio;
      _myProfile.nickname = nickname;

      _myProfile = await service.updateProfile(_myProfile);
      return "Success";
    } catch (e) {
      print("Error on updateProfile: ${e.toString()}");
      return "We cannot make this right now, please try again later";
    }
  }
}
