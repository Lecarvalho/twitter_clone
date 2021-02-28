import 'package:flutter/foundation.dart';
import 'package:twitter_clone/controllers/controller_base.dart';
import 'package:twitter_clone/models/auth_model.dart';
import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/services/profile_service_base.dart';

class ProfileController extends ControllerBase<ProfileServiceBase> {
  ProfileController({@required service}) : super(service: service);

  UserModel get profile => _profile;
  UserModel _profile;

  Future<void> getUserProfile(String userId) async {
    try {
      _profile = await service.getUserProfile(userId);
    } catch (e) {
      print("Error on getUserProfile: " + e);
    }
  }

  String _getCreateUserResponseMessage(CreateUserResponse response) {
    switch (response) {
      case CreateUserResponse.email_already_in_use:
        return "The email is already in use.";
      case CreateUserResponse.invalid_information:
        return "Invalid information. Please verify all the fields and try again.";
      case CreateUserResponse.success:
        return "We are almost done...";
      default: //general error
        return "We cannot make this right now, please try again later";
    }
  }

  Future<ResponseProfile> createUserProfile({
    String name,
    String emailAddress,
    String nickname,
    String password,
  }) async {
    var userModel = UserModel.toMap(
      emailAddress: emailAddress,
      name: name,
      nickname: nickname,
    );

    if (AuthModel.isValidEmailPassword(emailAddress, password)) {
      var createUserResponse = await service.createUserProfile(
        userModel,
        password,
      );

      return ResponseProfile(
        message: _getCreateUserResponseMessage(createUserResponse),
        success: createUserResponse == CreateUserResponse.success,
      );
    } else {
      return ResponseProfile(
        message: _getCreateUserResponseMessage(
          CreateUserResponse.invalid_information,
        ),
        success: false,
      );
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
