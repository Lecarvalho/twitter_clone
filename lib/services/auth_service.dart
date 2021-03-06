// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// import 'auth_service_base.dart';

// class AuthService extends AuthServiceBase {
//   FirebaseAuth auth = FirebaseAuth.instance;

//   @override
//   Future<AuthResponse> createOrSignInWithGoogle() async {
//     AuthResponse response;

//     try {
//       final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       // final GoogleAuthCredential credential = GoogleAuthProvider.credential(
//       //   accessToken: googleAuth.accessToken,
//       //   idToken: googleAuth.idToken,
//       // );

//       // var userCredential = await auth.signInWithCredential(credential);

//       // userCredential.user.metadata.
//       response = AuthResponse(responseType: AuthResponseType.success);
//     } on FirebaseAuthException catch (e) {
//       response = AuthResponse(responseType: errorHandler(e.code));
//     } catch (e) {
//       response = AuthResponse(responseType: AuthResponseType.general_error);
//     }

//     return response;
//   }

//   @override
//   Future<AuthResponse> createUserWithEmailPassword({
//     required String email,
//     required String password,
//     required String name,
//     required String nickname,
//   }) {
//     // TODO: implement createUserWithEmailPassword
//     throw UnimplementedError();
//   }

//   @override
//   Future<AuthResponse> signInWithEmailPassword(String email, String password) {
//     // TODO: implement signInWithEmailPassword
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> signOff() {
//     // TODO: implement signOff
//     throw UnimplementedError();
//   }

//   @override
//   Future<AuthResponse> tryAutoSigIn() {
//     // TODO: implement tryAutoSigIn
//     throw UnimplementedError();
//   }

//   AuthResponseType errorHandler(String errorCode) {
//     switch (errorCode) {
//       case "user-disabled":
//         return AuthResponseType.user_disabled;
//       case "account-exists-with-different-credential":
//         return AuthResponseType.email_already_in_use;
//       case "user-not-found":
//       case "wrong-password":
//         return AuthResponseType.invalid_email_or_password;
//       case "invalid-credential":
//       case "operation-not-allowed":
//         return AuthResponseType.general_error;
//       default:
//         return AuthResponseType.general_error;
//     }
//   }
// }
