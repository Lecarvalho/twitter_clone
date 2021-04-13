import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/services/providers/service_provider_base.dart';

import 'service_base.dart';

abstract class AuthServiceBase extends ServiceBase {
  AuthServiceBase(ServiceProviderBase provider) : super(provider);

  Future<AuthResponse> createOrSignInWithGoogle();

  Future<AuthResponse> createWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<AuthResponse> signInWithEmailAndPassword(
    String email,
    String password,
  );

  Future<void> signOut();

  Future<AuthResponse> tryAutoSigIn();
}

class AuthResponse {
  UserModel? user;
  bool get success =>
      user != null && message == AuthResponseMessage.success;
  String? message;

  AuthResponse({
    this.user,
    this.message,
  });

  factory AuthResponse.success(UserModel user) {
    return AuthResponse(
      message: AuthResponseMessage.success,
      user: user,
    );
  }

  factory AuthResponse.cancel() {
    return AuthResponse(message: "");
  }
}

class AuthResponseMessage {
  AuthResponseMessage._();
  static const String invalid_email_or_password = "Invalid email or password";
  static const String email_already_in_use = "The email is already in use.";
  static const String user_disabled =
      "The user is disabled, please contact the support";
  static const String general_error =
      "We cannot make this right now, please try again later";
  static const String success = "Success";
  static const String user_not_found = "User not found, please try again";
  static const String weak_password = "The password is too weak, please fix it";
}
