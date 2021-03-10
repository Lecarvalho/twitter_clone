import 'package:twitter_clone/models/user_model.dart';

import '../user_service_base.dart';
import 'mock_tools.dart';
import 'service_provider_mock.dart';

class UserServiceMock extends UserServiceBase {
  UserServiceMock(ServiceProviderMock provider) : super(provider);

  @override
  Future<UserServiceResponse> createOrSignInWithGoogle() async {
    UserServiceResponse response;

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

      response = UserServiceResponse.success(user!);
    } catch (e) {
      print(
          "error in userServiceMock.createOrSignInWithGoogle ${e.toString()}");
      response = UserServiceResponse(
        message: UserServiceResponseMessage.general_error,
      );
    }

    return response;
  }

  @override
  Future<UserServiceResponse> createWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    UserServiceResponse response;

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

      response = UserServiceResponse.success(user!);
    } catch (e) {
      print(
          "error in userServiceMock.createWithEmailAndPassword ${e.toString()}");
      response = UserServiceResponse(
        message: UserServiceResponseMessage.general_error,
      );
    }

    return response;
  }

  @override
  Future<UserServiceResponse> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    UserServiceResponse response;

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

      response = UserServiceResponse.success(user!);
    } catch (e) {
      print(
          "error in userServiceMock.signInWithEmailAndPassword ${e.toString()}");
      response = UserServiceResponse(
        message: UserServiceResponseMessage.general_error,
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
  Future<UserServiceResponse> tryAutoSigIn() async {
    print("tryAutoSigIn");

    UserServiceResponse response;

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
        response = UserServiceResponse(
          message: "",
        );
      else {
        response = UserServiceResponse.success(user);
      }
    } catch (e) {
      print("error in userServiceMock.tryAutoSigIn ${e.toString()}");

      response = UserServiceResponse(
        message: UserServiceResponseMessage.general_error,
      );
    }

    return response;
  }
}
