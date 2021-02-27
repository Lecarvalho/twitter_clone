import 'package:twitter_clone/models/auth_model.dart';
import 'package:twitter_clone/services/user_session_service_base.dart';
import 'package:twitter_clone/services/mock/json_tools.dart';

class UserSessionServiceMock implements UserSessionServiceBase {
  @override
  Future<AuthModel> signInWithGoogle() async {
    print("SignIn with Google!");

    return await JsonTools.jsonToModel<AuthModel>(
      "assets/json/login.json",
      (data) => AuthModel.fromMap(data),
    );
  }

  @override
  Future<AuthModel> tryConnect() async {
    return await JsonTools.jsonToModel<AuthModel>(
      "assets/json/login.json",
      (data) => AuthModel.fromMap(data),
    );
  }

  @override
  Future<void> follow(String myUserId, String toFollowUserId) async {
    print("following $toFollowUserId");
  }

  @override
  Future<void> unfollow(String myUserId, String toUnfollowUserId) async {
    print("Unfollowing $toUnfollowUserId");
  }

  @override
  Future<AuthModel> signInWithEmailPassword(String email, String password) async {
    print("SignIn with email and password!");
    print("email $email");
    print("password $password");
    return null;
  }

  @override
  Future<void> signOff() async {
    print("Signoff!");
  }
}
