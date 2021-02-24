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
    _authUser = await super.service.sigInWithGoogle();
  }

  Future<void> tryConnect() async {
    _authUser = await super.service.tryConnect();
  }

  Future<void> follow(String userId) async {
    _authUser.following.add(userId);
  }

  Future<void> unfollow(String userId) async {
    _authUser.following.remove(userId);
  }
}
