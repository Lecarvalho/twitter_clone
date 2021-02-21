// import 'package:firebase_core/firebase_core.dart';

class InitService {
  static Future<void> init() async {
    // await Firebase.initializeApp();
    await Future.delayed(Duration(seconds: 1));
  }
}