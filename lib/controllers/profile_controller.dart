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

  Future<void> refreshMyProfile()async {
    try{
      _myProfile = (await service.getProfile(_myProfile.id))!;
    } 
    catch (e) {
      print("Error on refreshMyProfile: ${e.toString()}");

    }
  }

  Future<bool> amIFollowingProfile(String myProfileId, String otherProfileId) async {
    try {
      return await service.amIFollowingProfile(myProfileId, otherProfileId);
    } catch (e) {
      print("Error on amIFollowingProfile: ${e.toString()}");
      return false;
    }
  }

  set setMyProfile(ProfileModel myProfile) => _myProfile = myProfile;

  Future<void> follow(String toFollowUserId) async {
    try {
      service.follow(_myProfile.id, toFollowUserId);
    } catch (e) {
      print("Error on follow: ${e.toString()}");
    }
  }

  Future<void> unfollow(String toUnfollowUserId) async {
    try {
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

  Future<bool> isNicknameAvailable(String nickname) async {
    return await service.isNicknameAvailable(nickname);
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
        var filename = _getAvatarFilename(avatarLocalPath!, nickname);
        var avatarUrl = await service.uploadAvatar(avatarLocalPath, filename);

        _myProfile.avatar = avatarUrl;
      }

      _myProfile.bio = bio;
      _myProfile.nickname = nickname;

      _myProfile = await service.updateProfile(
        _myProfile.id,
        ProfileModel.getMapForUpdateProfile(
          nickname: nickname,
          avatar: _myProfile.avatar!,
          bio: bio,
        ),
      );
      return "Success";
    } catch (e) {
      print("Error on updateProfile: ${e.toString()}");
      return "We cannot make this right now, please try again later";
    }
  }

  String _getAvatarFilename(String selectedPicture, String nickname) {
    final fileExtension = selectedPicture.split('/').last.split(".").last;
    return nickname + DateTime.now().toUtc().toString() + "." + fileExtension;
  }
}
