import 'package:twitter_clone/models/auth_model.dart';

import 'service_base.dart';

abstract class UserSessionServiceBase extends ServiceBase {
  Future<AuthModel> signInWithGoogle();
  Future<AuthModel> signInWithEmailPassword(String email, String password);
  Future<AuthModel> tryConnect();
  Future<void> signOff();
  Future<void> follow(String myUserId, String toFollowUserId);
  Future<void> unfollow(String myUserId, String toUnfollowUserId);
}