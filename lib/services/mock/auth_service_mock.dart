import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/services/auth_service_base.dart';
import 'package:twitter_clone/services/mock/mock_tools.dart';

class AuthServiceMock implements AuthServiceBase {
  @override
  Future<AuthResponse> createUserWithEmailPassword({
    String email,
    String password,
    String name,
    String nickname,
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

    return AuthResponse(
      userAuth: myUserAuth,
      responseType: AuthResponseType.success,
    );
  }

  @override
  Future<AuthResponse> createOrSignInWithGoogle() async {
    print("SignIn with Google!");

    var myUserAuth = await MockTools.jsonToModel<UserModel>(
      "assets/json/email_pwd_or_google_signin.json",
      (data) => UserModel.fromMap(data),
    );

    await MockTools.simulateRequestDelay();

    if (myUserAuth != null) {
      return AuthResponse(
        userAuth: myUserAuth,
        responseType: AuthResponseType.success,
      );
    } else {
      return AuthResponse(
        responseType: AuthResponseType.user_disabled,
      );
    }
  }

  @override
  Future<AuthResponse> tryAutoSigIn() async {
    print("tryAutoSigIn");

    var myUserAuth = await MockTools.jsonToModel<UserModel>(
      "assets/json/email_pwd_or_google_signin.json",
      (data) => UserModel.fromMap(data),
    );

    await MockTools.simulateQuickRequestDelay();

    myUserAuth = null;

    if (myUserAuth != null) {
      return AuthResponse(
        userAuth: myUserAuth,
        responseType: AuthResponseType.success,
      );
    } else {
      return AuthResponse(
        responseType: AuthResponseType.general_error,
      );
    }
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

    if (myUserAuth != null) {
      return AuthResponse(
        userAuth: myUserAuth,
        responseType: AuthResponseType.success,
      );
    } else {
      return AuthResponse(
        responseType: AuthResponseType.general_error,
      );
    }
  }

  @override
  Future<void> signOff() async {
    await MockTools.simulateQuickRequestDelay();

    print("Signoff!");
  }
}
