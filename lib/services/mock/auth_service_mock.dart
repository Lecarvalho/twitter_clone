import 'package:twitter_clone/models/user_model.dart';

import '../auth_service_base.dart';
import 'mock_tools.dart';
import 'service_provider_mock.dart';

class AuthServiceMock extends AuthServiceBase {
  AuthServiceMock(ServiceProviderMock provider) : super(provider);

  @override
  Future<AuthResponse> createOrSignInWithGoogle() async {
    AuthResponse response;

    try {
      var user = await MockTools.jsonToModel<UserModel>(
        "assets/json/create_or_signin_with_google.json",
        (data) => UserModel(
          uid: data["uid"],
          email: data["email"],
          displayName: data["displayName"],
        ),
      );

      MockTools.simulateRequestDelay();

      response = AuthResponse.success(user!);
    } catch (e) {
      print(
          "error in userServiceMock.createOrSignInWithGoogle ${e.toString()}");
      response = AuthResponse(
        message: AuthResponseMessage.general_error,
      );
    }

    return response;
  }

  @override
  Future<AuthResponse> createWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    AuthResponse response;

    try {
      var user = await MockTools.jsonToModel<UserModel>(
        "assets/json/create_with_email_password.json",
        (data) => UserModel(
          uid: data["uid"],
          email: data["email"],
          displayName: data["displayName"],
        ),
      );

      MockTools.simulateRequestDelay();

      response = AuthResponse.success(user!);
    } catch (e) {
      print(
          "error in userServiceMock.createWithEmailAndPassword ${e.toString()}");
      response = AuthResponse(
        message: AuthResponseMessage.general_error,
      );
    }

    return response;
  }

  @override
  Future<AuthResponse> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    AuthResponse response;

    try {
      var user = await MockTools.jsonToModel<UserModel>(
        "assets/json/sigin_with_email_password.json",
        (data) => UserModel(
          uid: data["uid"],
          email: data["email"],
          displayName: data["displayName"],
        ),
      );

      MockTools.simulateRequestDelay();

      response = AuthResponse.success(user!);
    } catch (e) {
      print(
          "error in userServiceMock.signInWithEmailAndPassword ${e.toString()}");
      response = AuthResponse(
        message: AuthResponseMessage.general_error,
      );
    }

    return response;
  }

  @override
  Future<void> signOut() async {
    await MockTools.simulateQuickRequestDelay();

    print("signOut!");
  }

  @override
  Future<AuthResponse> tryAutoSigIn() async {
    print("tryAutoSigIn");

    AuthResponse response;

    try {
      var user = await MockTools.jsonToModel<UserModel>(
        "assets/json/auto_signin.json",
        (data) => UserModel(
          email: data["email"],
          displayName: data["displayName"],
          uid: data["uid"],
        ),
      );

      user = null;

      await MockTools.simulateQuickRequestDelay();

      if (user == null)
        response = AuthResponse(
          message: "",
        );
      else {
        response = AuthResponse.success(user);
      }
    } catch (e) {
      print("error in userServiceMock.tryAutoSigIn ${e.toString()}");

      response = AuthResponse(
        message: AuthResponseMessage.general_error,
      );
    }

    return response;
  }
}
