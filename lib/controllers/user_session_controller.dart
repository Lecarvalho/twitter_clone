import 'package:flutter/foundation.dart';
import 'package:twitter_clone/controllers/controller_base.dart';
import 'package:twitter_clone/models/auth_model.dart';
import 'package:twitter_clone/services/user_session_service_base.dart';

class UserSessionController extends ControllerBase<UserSessionServiceBase> {
  UserSessionController({@required service}) : super(service: service);

  AuthModel _authUser;

  bool get isLoggedIn => _authUser != null;
  AuthModel get authUser => _authUser;

  Future<void> signInWithGoogle() async {
    try {
      _authUser = await service.signInWithGoogle();
    } catch (e) {
      print("Error on signInWithGoogle: " + e);
    }
  }

  Future<String> signInWithEmailPassword(String email, String password) async {
    try {
      _authUser = await service.signInWithEmailPassword(email, password);
      if (_authUser == null){
        return "User and password not found";
      }
      else {
        return "Success";
      }
    } catch (e) {
      print("Error on signInWithEmailPassword: " + e);
    }
    return "Error";
  }

  Future<void> tryConnect() async {
    try {
      _authUser = await super.service.tryConnect();
      _authUser = null;
    } catch (e) {
      print("Error on tryConnect: " + e);
    }
  }

  Future<void> signOff() async {
    try {
      _authUser = null;
      service.signOff();
    } catch (e) {
      print("Error on tryConnect: " + e);
    }
  }

  Future<void> follow(String toFollowUserId) async {
    try {
      _authUser.following.add(toFollowUserId);
      service.follow(_authUser.userId, toFollowUserId);
    } catch (e) {
      print("Error on follow: " + e);
    }
  }

  Future<void> unfollow(String toUnfollowUserId) async {
    try {
      _authUser.following.remove(toUnfollowUserId);
      service.unfollow(_authUser.userId, toUnfollowUserId);
    } catch (e) {
      print("Error on follow: " + e);
    }
  }
}
