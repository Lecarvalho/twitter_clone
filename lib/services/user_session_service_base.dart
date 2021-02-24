import 'package:twitter_clone/models/auth_model.dart';

import 'service_base.dart';

abstract class UserSessionServiceBase extends ServiceBase {
  Future<AuthModel> sigInWithGoogle();
  Future<AuthModel> tryConnect();
  Future<void> follow(String myUserId, String toFollowUserId);
  Future<void> unfollow(String myUserId, String toUnfollowUserId);
}