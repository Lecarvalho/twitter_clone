import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/services/providers/auth_provider.dart';
import 'user_service_base.dart';

class UserService extends UserServiceBase {
  late AuthProvider _provider;

  UserService(AuthProvider provider) : super(provider) {
    _provider = provider;
  }

  @override
  Future<UserServiceResponse> createOrSignInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return UserServiceResponse.cancel();
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _provider.firebaseAuth.signInWithCredential(credential);

      return _returnSuccess(userCredential);
    } on FirebaseAuthException catch (e) {
      return UserServiceResponse(message: _getErrorMessage(e.code));
    } catch (e) {
      print("Error in UserService.createOrSignInWithGoogle, ${e.toString()}");
      return UserServiceResponse(
        message: UserServiceResponseMessage.general_error,
      );
    }
  }

  @override
  Future<UserServiceResponse> createWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential =
          await _provider.firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user!.updateProfile(displayName: name);

      final userCredentialUpdated = await _provider.firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return _returnSuccess(userCredentialUpdated);
    } on FirebaseAuthException catch (e) {
      return UserServiceResponse(message: _getErrorMessage(e.code));
    } catch (e) {
      print("Error in UserService.createWithEmailAndPassword, ${e.toString()}");
      return UserServiceResponse(
        message: UserServiceResponseMessage.general_error,
      );
    }
  }

  @override
  Future<UserServiceResponse> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential =
          await _provider.firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return _returnSuccess(userCredential);
    } on FirebaseAuthException catch (e) {
      return UserServiceResponse(message: _getErrorMessage(e.code));
    } catch (e) {
      print("Error in UserService.signInWithEmailAndPassword, ${e.toString()}");
      return UserServiceResponse(
        message: UserServiceResponseMessage.general_error,
      );
    }
  }

  @override
  Future<void> signOut() async {
    await _provider.firebaseAuth.signOut();
  }

  @override
  Future<UserServiceResponse> tryAutoSigIn() async {
    if (_provider.firebaseAuth.currentUser == null) {
      return UserServiceResponse(
        message: "",
      );
    }

    return UserServiceResponse.success(
      UserModel(
        displayName: _provider.firebaseAuth.currentUser!.displayName!,
        email: _provider.firebaseAuth.currentUser!.email!,
        uid: _provider.firebaseAuth.currentUser!.uid,
      ),
    );
  }

  String _getErrorMessage(String errorCode) {
    print(errorCode);
    switch (errorCode) {
      case "account-exists-with-different-credential":
        return UserServiceResponseMessage.email_already_in_use;
      case "invalid-credential":
      case "wrong-password":
        return UserServiceResponseMessage.invalid_email_or_password;
      case "operation-not-allowed":
        return UserServiceResponseMessage.general_error;
      case "user-disabled":
        return UserServiceResponseMessage.user_disabled;
      case "user-not-found":
        return UserServiceResponseMessage.user_not_found;
      case "weak-password":
        return UserServiceResponseMessage.weak_password;
      default:
        return UserServiceResponseMessage.general_error;
    }
  }

  UserServiceResponse _returnSuccess(UserCredential credential) {
    return UserServiceResponse.success(
      UserModel(
        uid: credential.user!.uid,
        displayName: credential.user!.displayName!,
        email: credential.user!.email!,
      ),
    );
  }
}
