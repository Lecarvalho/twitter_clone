import 'package:flutter/foundation.dart';
import 'package:twitter_clone/controllers/controller_base.dart';
import 'package:twitter_clone/models/profile_model.dart';
import 'package:twitter_clone/services/pick_image_service.dart';
import 'package:twitter_clone/services/profile_service_base.dart';

class ProfileController extends ControllerBase<ProfileServiceBase> {
  ProfileController({@required service}) : super(service: service);

  ProfileModel? get profile => _profile;
  ProfileModel? _profile;

  ProfileModel? _myProfile;
  ProfileModel? get myProfile => _myProfile;

  bool get hasProfile => _myProfile != null;

  Future<void> getProfile(String profileId) async {
    try {
      _profile = await service.getProfile(profileId);
    } catch (e) {
      print("Error on getProfile: " + e.toString());
    }
  }

  Future<void> getMyProfile(String profileId) async {
    try {
      await getProfile(profileId);
      _myProfile = profile;
    } catch (e) {
      print("Error on getMyProfile: " + e.toString());
    }
  }

  Future<void> follow(String toFollowUserId) async {
    try {
      _myProfile!.following.add(toFollowUserId);
      service.follow(_myProfile!.id, toFollowUserId);
    } catch (e) {
      print("Error on follow: " + e.toString());
    }
  }

  Future<void> unfollow(String toUnfollowUserId) async {
    try {
      _myProfile!.following.remove(toUnfollowUserId);
      service.unfollow(_myProfile!.id, toUnfollowUserId);
    } catch (e) {
      print("Error on unfollow: " + e.toString());
    }
  }

  String _getResponseMessage(ProfileResponseType? responseType) {
    switch (responseType) {
      case ProfileResponseType.invalid_information:
        return "Invalid information";
      case ProfileResponseType.success:
        return "Success";
      default:
        return "We cannot make this right now, please try again later";
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

  Future<String> createProfile({
    required String bio,
    String? avatarLocalPath,
    required String name,
    required String nickname,
    required String userId,
  }) async {
    try {
      var msgValidation = validateProfile(bio, avatarLocalPath);

      if (msgValidation != "Success") {
        return msgValidation;
      }

      var avatarUrl = await service.uploadAvatar(avatarLocalPath!);

      var response = await service.createProfile(
        avatar: avatarUrl,
        bio: bio,
        inscriptionDate: DateTime.now(),
        name: name,
        nickname: nickname,
        userId: userId,
      );

      return _getResponseMessage(response);
    } catch (e) {
      print("Error on createProfile: " + e.toString());
    }

    return _getResponseMessage(null);
  }

  Future<String> updateProfile(String bio, String? avatarLocalPath) async {
    try {
      var msgValidation =
          validateProfile(bio, avatarLocalPath ?? _myProfile!.avatar);

      if (msgValidation != "Success") {
        return msgValidation;
      }

      var hasChangePicture = avatarLocalPath?.isNotEmpty ?? false;

      if (hasChangePicture) {
        var avatarUrl = await service.uploadAvatar(avatarLocalPath!);

        _myProfile!.avatar = avatarUrl;
      }

      _myProfile!.bio = bio;
      var response = await service.updateProfile(_myProfile!);
      return _getResponseMessage(response);
    } catch (e) {
      print("Error on updateProfile: " + e.toString());
    }

    return _getResponseMessage(null);
  }

  String validateProfile(String? bio, String? avatar) {
    if (avatar?.isEmpty ?? true) {
      return "Please set a picture for your profile";
    } else if (bio?.isEmpty ?? true) {
      return "Please provide a bio for your profile";
    } else {
      return "Success";
    }
  }
}
