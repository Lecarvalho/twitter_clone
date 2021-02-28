import 'package:twitter_clone/models/auth_model.dart';
import 'package:twitter_clone/services/user_session_service_base.dart';
import 'package:twitter_clone/services/mock/json_tools.dart';

class UserSessionServiceMock implements UserSessionServiceBase {
  @override
  AuthModel get authModel => _authModel;
  AuthModel _authModel;

  bool get isLoggedIn => _authModel != null;

  @override
  Future<AuthResponse> signInWithGoogle() async {
    print("SignIn with Google!");

    _authModel = await JsonTools.jsonToModel<AuthModel>(
      "assets/json/login.json",
      (data) => AuthModel.fromMap(data),
    );

    if (isLoggedIn) {
      return AuthResponse.success;
    } else {
      return AuthResponse.user_disabled;
    }
  }

  @override
  Future<AuthResponse> tryConnect() async {
    print("Try connect");

    _authModel = await JsonTools.jsonToModel<AuthModel>(
      "assets/json/login.json",
      (data) => AuthModel.fromMap(data),
    );

    _authModel = null;

    if (isLoggedIn) {
      return AuthResponse.success;
    } else {
      return AuthResponse.general_error;
    }
  }

  @override
  Future<void> follow(String toFollowUserId) async {
    _authModel.following.add(toFollowUserId);
    print("following $toFollowUserId");
  }

  @override
  Future<void> unfollow(String toUnfollowUserId) async {
    _authModel.following.remove(toUnfollowUserId);
    print("Unfollowing $toUnfollowUserId");
  }

  @override
  Future<AuthResponse> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    print("SignIn with email and password!");
    print("email $email");
    print("password $password");
    
    return AuthResponse.success;

  }

  @override
  Future<void> signOff() async {
    print("Signoff!");
    _authModel = null;
  }
}
