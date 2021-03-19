import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'service_provider_base.dart';

class AuthProvider extends ServiceProviderBase {

  late FirebaseAuth firebaseAuth;
  
  @override
  Future<void> init() async {  
    firebaseAuth = FirebaseAuth.instance;
  }
  
}