import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/services/auth_service_base.dart';
import 'package:twitter_clone/services/mock/mock_tools.dart';

class AuthServiceMock implements AuthServiceBase {
  @override
  Future<AuthResponse> createUserWithEmailPassword({
    required String email,
    required String password,
    required String name,
    required String nickname,
  }) async {
    print("Create user auth");
    print("name $name");
    print("email $email");
    print("password $password");
    print("nickname $nickname");

    var myUserAuth = await MockTools.jsonToModel<UserModel>(
      "assets/json/creating_user.json",
      (data) => UserModel.fromMap(data),
    );

    await MockTools.simulateRequestDelay();

    var authResponse = AuthResponse(
      responseType: AuthResponseType.success,
      userAuth: myUserAuth
    );

    return authResponse;
  }

  @override
  Future<AuthResponse> createOrSignInWithGoogle() async {
    print("SignIn with Google!");

    var myUserAuth = await MockTools.jsonToModel<UserModel>(
      "assets/json/email_pwd_or_google_signin.json",
      (data) => UserModel.fromMap(data),
    );

    await MockTools.simulateRequestDelay();

    var authResponse = AuthResponse(
      responseType: AuthResponseType.success,
      userAuth: myUserAuth
    );

    return authResponse;
  }

  @override
  Future<AuthResponse> tryAutoSigIn() async {
    print("tryAutoSigIn");

    var myUserAuth = await MockTools.jsonToModel<UserModel>(
      "assets/json/email_pwd_or_google_signin.json",
      (data) => UserModel.fromMap(data),
    );

    await MockTools.simulateQuickRequestDelay();

    var authResponse = AuthResponse(
      responseType: AuthResponseType.success,
      userAuth: myUserAuth,
    );

    return authResponse;
  }

  @override
  Future<AuthResponse> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    print("SignIn with email and password!");
    print("email $email");
    print("password $password");

    var myUserAuth = await MockTools.jsonToModel<UserModel>(
      "assets/json/email_pwd_or_google_signin.json",
      (data) => UserModel.fromMap(data),
    );

    await MockTools.simulateQuickRequestDelay();

    var authResponse = AuthResponse(
      responseType: AuthResponseType.success,
      userAuth: myUserAuth,
    );

    return authResponse;
  }

  @override
  Future<void> signOff() async {
    await MockTools.simulateQuickRequestDelay();

    print("Signoff!");
  }
}
