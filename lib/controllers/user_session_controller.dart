import 'package:flutter/foundation.dart';
import 'package:twitter_clone/controllers/controller_base.dart';
import 'package:twitter_clone/models/auth_model.dart';
import 'package:twitter_clone/services/user_session_service_base.dart';

class UserSessionController extends ControllerBase<UserSessionServiceBase> {
  UserSessionController({@required service}) : super(service: service);

  AuthModel get authModel => service.authModel;
  bool get isLoggedIn => service.isLoggedIn;

  String _getAuthResponseMessage(AuthResponse response) {
    switch (response) {
      case AuthResponse.email_already_in_use:
        return "The email is already in use.";
      case AuthResponse.invalid_email_or_password:
        return "Invalid email or password";
      case AuthResponse.success:
        return "Success";
      case AuthResponse.user_disabled:
        return "The user is disabled, please contact the support";
      default: //general error
        return "We cannot make this right now, please try again later";
    }
  }

  Future<String> signInWithGoogle() async {
    try {
      var authResponse = await service.signInWithGoogle();
      return _getAuthResponseMessage(authResponse);
    } catch (e) {
      print("Error on signInWithGoogle: " + e);
    }
    return _getAuthResponseMessage(AuthResponse.general_error);
  }

  

  Future<String> signInWithEmailPassword(String email, String password) async {
    try {
      if (AuthModel.isValidEmailPassword(email, password)) {
        var authResponse =
            await service.signInWithEmailPassword(email, password);
        return _getAuthResponseMessage(authResponse);
      } else {
        return _getAuthResponseMessage(AuthResponse.invalid_email_or_password);
      }
    } catch (e) {
      print("Error on signInWithEmailPassword: " + e);
    }
    return _getAuthResponseMessage(AuthResponse.general_error);
  }

  Future<String> tryConnect() async {
    try {
      var authResponse = await service.tryConnect();
      return _getAuthResponseMessage(authResponse);
    } catch (e) {
      print("Error on tryConnect: " + e);
    }
    return _getAuthResponseMessage(AuthResponse.general_error);
  }

  Future<void> signOff() async {
    try {
      service.signOff();
    } catch (e) {
      print("Error on tryConnect: " + e);
    }
  }

  Future<void> follow(String toFollowUserId) async {
    try {
      service.follow(toFollowUserId);
    } catch (e) {
      print("Error on follow: " + e);
    }
  }

  Future<void> unfollow(String toUnfollowUserId) async {
    try {
      service.unfollow(toUnfollowUserId);
    } catch (e) {
      print("Error on follow: " + e);
    }
  }
}
