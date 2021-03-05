import 'package:twitter_clone/models/user_model.dart';

import 'service_base.dart';

abstract class AuthServiceBase extends ServiceBase {
  Future<AuthResponse> createUserWithEmailPassword({
    String email,
    String password,
    String name,
    String nickname,
  });
  Future<AuthResponse> createOrSignInWithGoogle();
  Future<AuthResponse> signInWithEmailPassword(String email, String password);
  Future<AuthResponse> tryAutoSigIn();
  Future<void> signOff();
}

class AuthResponse {
  AuthResponse({
    this.responseType,
    this.userAuth,
  });

  AuthResponseType responseType;
  UserModel userAuth;
}

enum AuthResponseType {
  invalid_email_or_password,
  email_already_in_use,
  user_disabled,
  general_error,
  success
}
