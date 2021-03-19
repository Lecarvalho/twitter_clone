import 'package:firebase_core/firebase_core.dart';

class CoreProvider {
  Future<void> init() async {
    await Firebase.initializeApp();
  }
}