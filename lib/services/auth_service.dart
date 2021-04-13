import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/services/providers/auth_provider.dart';
import 'auth_service_base.dart';

class AuthService extends AuthServiceBase {
  late AuthProvider _provider;

  AuthService(AuthProvider provider) : super(provider) {
    _provider = provider;
  }

  @override
  Future<AuthResponse> createOrSignInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return AuthResponse.cancel();
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
      return AuthResponse(message: _getErrorMessage(e.code));
    } catch (e) {
      print("Error in UserService.createOrSignInWithGoogle, ${e.toString()}");
      return AuthResponse(
        message: AuthResponseMessage.general_error,
      );
    }
  }

  @override
  Future<AuthResponse> createWithEmailAndPassword({
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
      return AuthResponse(message: _getErrorMessage(e.code));
    } catch (e) {
      print("Error in UserService.createWithEmailAndPassword, ${e.toString()}");
      return AuthResponse(
        message: AuthResponseMessage.general_error,
      );
    }
  }

  @override
  Future<AuthResponse> signInWithEmailAndPassword(
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
      return AuthResponse(message: _getErrorMessage(e.code));
    } catch (e) {
      print("Error in UserService.signInWithEmailAndPassword, ${e.toString()}");
      return AuthResponse(
        message: AuthResponseMessage.general_error,
      );
    }
  }

  @override
  Future<void> signOut() async {
    await _provider.firebaseAuth.signOut();
  }

  @override
  Future<AuthResponse> tryAutoSigIn() async {
    if (_provider.firebaseAuth.currentUser == null) {
      return AuthResponse(
        message: "",
      );
    }

    return AuthResponse.success(
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
        return AuthResponseMessage.email_already_in_use;
      case "invalid-credential":
      case "wrong-password":
        return AuthResponseMessage.invalid_email_or_password;
      case "operation-not-allowed":
        return AuthResponseMessage.general_error;
      case "user-disabled":
        return AuthResponseMessage.user_disabled;
      case "user-not-found":
        return AuthResponseMessage.user_not_found;
      case "weak-password":
        return AuthResponseMessage.weak_password;
      default:
        return AuthResponseMessage.general_error;
    }
  }

  AuthResponse _returnSuccess(UserCredential credential) {
    return AuthResponse.success(
      UserModel(
        uid: credential.user!.uid,
        displayName: credential.user!.displayName!,
        email: credential.user!.email!,
      ),
    );
  }
}
