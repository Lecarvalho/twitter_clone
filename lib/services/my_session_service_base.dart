import 'package:twitter_clone/models/my_session_model.dart';

import 'service_base.dart';

abstract class MySessionServiceBase extends ServiceBase {
  Future<AuthResponse> signInWithGoogle();
  Future<AuthResponse> signInWithEmailPassword(String email, String password);
  Future<AuthResponse> tryConnect();
  Future<void> signOff();
  Future<CreateUserResponseType> createUserProfile(
    MySessionModel mySession,
    String password,
  );
  Future<String> uploadAvatar(String userId, String selectedImagePath);

  Future<void> follow(String myProfileId, String toFollowUserId);
  Future<void> unfollow(String myProfileId, String toUnfollowUserId);

  Future<void> updateProfile(String myProfileId, String bio);
}

class AuthResponse {
  AuthResponse({
    this.responseType,
    this.mySession,
  });

  AuthResponseType responseType;
  MySessionModel mySession;
}

enum AuthResponseType {
  invalid_email_or_password,
  email_already_in_use,
  user_disabled,
  general_error,
  success
}

enum CreateUserResponseType {
  email_already_in_use,
  invalid_information,
  success,
}
