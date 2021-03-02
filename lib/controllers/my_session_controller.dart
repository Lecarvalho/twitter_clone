import 'package:flutter/foundation.dart';
import 'package:twitter_clone/models/my_session_model.dart';
import 'package:twitter_clone/models/profile_model.dart';
import 'package:twitter_clone/services/my_session_service_base.dart';
import 'package:twitter_clone/services/pick_image_service.dart';

import 'controller_base.dart';

class MySessionController extends ControllerBase<MySessionServiceBase> {
  MySessionController({@required service}) : super(service: service);

  MySessionModel _mySession;

  MySessionModel get mySession => _mySession;
  bool get amILoggedIn => _mySession != null;

  String _getAuthResponseMessage(AuthResponseType responseType) {
    switch (responseType) {
      case AuthResponseType.email_already_in_use:
        return "The email is already in use.";
      case AuthResponseType.invalid_email_or_password:
        return "Invalid email or password";
      case AuthResponseType.success:
        return "Success";
      case AuthResponseType.user_disabled:
        return "The user is disabled, please contact the support";
      default: //general error
        return "We cannot make this right now, please try again later";
    }
  }

  Future<String> signInWithGoogle() async {
    try {
      var authResponse = await service.signInWithGoogle();
      _mySession = authResponse.mySession;
      return _getAuthResponseMessage(authResponse.responseType);
    } catch (e) {
      print("Error on signInWithGoogle: " + e.toString());
    }
    return _getAuthResponseMessage(AuthResponseType.general_error);
  }

  Future<String> signInWithEmailPassword(String email, String password) async {
    try {
      if (MySessionModel.isValidEmailPassword(email, password)) {
        var authResponse = await service.signInWithEmailPassword(
          email,
          password,
        );
        _mySession = authResponse.mySession;
        return _getAuthResponseMessage(authResponse.responseType);
      } else {
        return _getAuthResponseMessage(
          AuthResponseType.invalid_email_or_password,
        );
      }
    } catch (e) {
      print("Error on signInWithEmailPassword: " + e.toString());
    }
    return _getAuthResponseMessage(AuthResponseType.general_error);
  }

  Future<String> tryConnect() async {
    try {
      var authResponse = await service.tryConnect();
      _mySession = authResponse.mySession;
      return _getAuthResponseMessage(authResponse.responseType);
    } catch (e) {
      print("Error on tryConnect: " + e.toString());
    }
    return _getAuthResponseMessage(AuthResponseType.general_error);
  }

  Future<void> signOff() async {
    try {
      service.signOff();
      _mySession = null;
    } catch (e) {
      print("Error on tryConnect: " + e.toString());
    }
  }

  Future<void> follow(String toFollowUserId) async {
    try {
      _mySession.following.add(toFollowUserId);
      _mySession.followingCount++;
      service.follow(_mySession.profileId, toFollowUserId);
    } catch (e) {
      print("Error on follow: " + e.toString());
    }
  }

  Future<void> unfollow(String toUnfollowUserId) async {
    try {
      _mySession.following.remove(toUnfollowUserId);
      _mySession.followingCount--;
      service.unfollow(_mySession.profileId, toUnfollowUserId);
    } catch (e) {
      print("Error on follow: " + e.toString());
    }
  }

  Future<ResponseProfile> createUserProfile({
    String name,
    String email,
    String nickname,
    String password,
  }) async {
    var mySession = MySessionModel.toMap(
      email: email,
      name: name,
      nickname: nickname,
      followingCount: 0,
      followersCount: 0,
    );

    if (MySessionModel.isValidEmailPassword(email, password)) {
      var createUserResponse = await service.createUserProfile(
        mySession,
        password,
      );

      return ResponseProfile(
        message: _getCreateUserResponseMessage(createUserResponse),
        success: createUserResponse == CreateUserResponseType.success,
      );
    } else {
      return ResponseProfile(
        message: _getCreateUserResponseMessage(
          CreateUserResponseType.invalid_information,
        ),
        success: false,
      );
    }
  }

  Future<void> uploadAvatar(String profileId) async {
    try {
      var avatarLocalPath = await _selectAvatar();

      if (avatarLocalPath != null) {
        var avatarUrl = await service.uploadAvatar(
          profileId,
          avatarLocalPath,
        );

        _mySession.myProfile.avatar = avatarUrl;
      }
    } catch (e) {
      print("Error on uploadAvatar: " + e.toString());
    }
  }

  Future<String> _selectAvatar() async {
    var pickImageService = PickImageService();

    var imagePath = await pickImageService.pickImagePath();
    return imagePath;
  }

  Future<String> resizeAvatar() async {
    // call an api to resize avatar
    throw UnimplementedError();
  }

  String _getCreateUserResponseMessage(CreateUserResponseType response) {
    switch (response) {
      case CreateUserResponseType.email_already_in_use:
        return "The email is already in use.";
      case CreateUserResponseType.invalid_information:
        return "Invalid information. Please verify all the fields and try again.";
      case CreateUserResponseType.success:
        return "We are almost done...";
      default: //general error
        return "We cannot make this right now, please try again later";
    }
  }

  void setMyProfile(ProfileModel myProfile) {
    _mySession.myProfile = myProfile;
  }

  Future<String> updateProfile(String bio) async {
    if (_mySession.myProfile.avatar?.isEmpty ?? true) {
      return "Please set a picture for your profile";
    } else if (bio?.isEmpty ?? true) {
      return "Please provide a bio for your profile";
    } else {
      _mySession.myProfile.bio = bio;
      service.updateProfile(_mySession.profileId, bio);
      return "Success";
    }
  }
}

class ResponseProfile {
  ResponseProfile({
    @required this.message,
    @required this.success,
  });
  String message;
  bool success;
}
