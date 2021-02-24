import 'package:flutter/foundation.dart';
import 'package:twitter_clone/controllers/controller_base.dart';
import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/services/auth_service_base.dart';

class AuthController extends ControllerBase<AuthServiceBase> {
  AuthController({@required AuthServiceBase service}) : super(service: service);

  UserModel _userSession;
  
  bool get isLoggedIn => _userSession != null;
  UserModel get userSession => _userSession;

  Future<void> signInWithGoogle() async {
    _userSession = await super.service.sigInWithGoogle();
  }

  Future<void> tryConnect() async {
    _userSession = await super.service.tryConnect();
  }
}
