import 'package:twitter_clone/models/auth_model.dart';

import 'service_base.dart';

abstract class UserSessionServiceBase extends ServiceBase {

  AuthModel get authModel;
  bool get isLoggedIn;

  Future<AuthResponse> signInWithGoogle();
  Future<AuthResponse> signInWithEmailPassword(String email, String password);
  Future<AuthResponse> tryConnect();
  Future<void> signOff();
  Future<void> follow(String toFollowUserId);
  Future<void> unfollow(String toUnfollowUserId);
}

enum AuthResponse {
  invalid_email_or_password,
  email_already_in_use,
  user_disabled,
  general_error,
  success
}