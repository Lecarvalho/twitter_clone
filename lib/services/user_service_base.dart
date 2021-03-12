import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/services/providers/service_provider_base.dart';

import 'service_base.dart';

abstract class UserServiceBase extends ServiceBase {
  UserServiceBase(ServiceProviderBase provider) : super(provider);

  Future<UserServiceResponse> createOrSignInWithGoogle();

  Future<UserServiceResponse> createWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserServiceResponse> signInWithEmailAndPassword(
    String email,
    String password,
  );

  Future<void> signOut();

  Future<UserServiceResponse> tryAutoSigIn();
}

class UserServiceResponse {
  UserModel? user;
  bool get success =>
      user != null && message == UserServiceResponseMessage.success;
  String message;

  UserServiceResponse({
    this.user,
    required this.message,
  });

  factory UserServiceResponse.success(UserModel user) {
    return UserServiceResponse(
      message: UserServiceResponseMessage.success,
      user: user,
    );
  }

  factory UserServiceResponse.cancel() {
    return UserServiceResponse(message: "");
  }
}

class UserServiceResponseMessage {
  UserServiceResponseMessage._();
  static const String invalid_email_or_password = "Invalid email or password";
  static const String email_already_in_use = "The email is already in use.";
  static const String user_disabled =
      "The user is disabled, please contact the support";
  static const String general_error =
      "We cannot make this right now, please try again later";
  static const String success = "Success";
  static const String user_not_found = "User not found, please try again";
}
