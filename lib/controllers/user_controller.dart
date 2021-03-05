import 'package:flutter/foundation.dart';
import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/services/auth_service_base.dart';

import 'controller_base.dart';

class UserController extends ControllerBase<AuthServiceBase> {
  UserController({@required service}) : super(service: service);

  UserModel _user;
  UserModel get user => _user;

  bool get amILoggedIn => _user != null;

  Future<String> signInWithGoogle() async {
    try {
      var authResponse = await service.createOrSignInWithGoogle();
      _user = authResponse.userAuth;
      return _getCreateUserResponseMessage(authResponse.responseType);
    } catch (e) {
      print("Error on signInWithGoogle: " + e.toString());
      return _getCreateUserResponseMessage(AuthResponseType.general_error);
    }
  }

  Future<String> signInWithEmailPassword(String email, String password) async {
    try {
      if (UserModel.isValidEmailPassword(email, password)) {
        var authResponse = await service.signInWithEmailPassword(
          email,
          password,
        );
        _user = authResponse.userAuth;
        return _getCreateUserResponseMessage(authResponse.responseType);
      } else {
        return _getCreateUserResponseMessage(
          AuthResponseType.invalid_email_or_password,
        );
      }
    } catch (e) {
      print("Error on signInWithEmailPassword: " + e.toString());
      return _getCreateUserResponseMessage(AuthResponseType.general_error);
    }
  }

  Future<String> tryAutoSigIn() async {
    try {
      var authResponse = await service.tryAutoSigIn();
      _user = authResponse.userAuth;
      return _getCreateUserResponseMessage(authResponse.responseType);
    } catch (e) {
      print("Error on tryAutoSigIn: " + e.toString());
      return _getCreateUserResponseMessage(AuthResponseType.general_error);
    }
  }

  Future<void> signOff() async {
    try {
      service.signOff();
      _user = null;
    } catch (e) {
      print("Error on tryConnect: " + e.toString());
    }
  }

  Future<String> createUserWithEmailPassword({
    String name,
    String email,
    String nickname,
    String password,
  }) async {
    if (UserModel.isValidEmailPassword(email, password)) {
      var authResponse = await service.createUserWithEmailPassword(
        email: email,
        password: password,
        name: name,
        nickname: nickname,
      );

      _user = authResponse.userAuth;
      return _getCreateUserResponseMessage(authResponse.responseType);
    } else {
      return "Invalid information. Please verify all the fields and try again.";
    }
  }

  String _getCreateUserResponseMessage(AuthResponseType response) {
    switch (response) {
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
}

class ResponseProfile {
  ResponseProfile({
    @required this.message,
    @required this.success,
  });
  String message;
  bool success;
}
