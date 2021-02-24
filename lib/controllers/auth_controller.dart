import 'package:flutter/foundation.dart';
import 'package:twitter_clone/controllers/controller_base.dart';
import 'package:twitter_clone/models/auth_model.dart';
import 'package:twitter_clone/services/auth_service_base.dart';

class AuthController extends ControllerBase<AuthServiceBase> {
  AuthController({@required service}) : super(service: service);

  AuthModel _authUser;

  bool get isLoggedIn => _authUser != null;
  AuthModel get authUser => _authUser;

  Future<void> signInWithGoogle() async {
    try {
      _authUser = await super.service.sigInWithGoogle();
    } catch (e) {
      print("Error on signInWithGoogle: " + e);
    }
  }

  Future<void> tryConnect() async {
    try {
      _authUser = await super.service.tryConnect();
    } catch (e) {
      print("Error on tryConnect: " + e);
    }
  }

  Future<void> follow(String userId) async {
    try {
      _authUser.following.add(userId);
    } catch (e) {
      print("Error on follow: " + e);
    }
  }

  Future<void> unfollow(String userId) async {
    try {
      _authUser.following.remove(userId);
    } catch (e) {
      print("Error on follow: " + e);
    }
  }
}
