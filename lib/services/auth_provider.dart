import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_clone/services/service_provider_base.dart';

class AuthProvider extends ServiceProviderBase {

  final firebaseAuth = FirebaseAuth.instance;
  
  @override
  Future<void> init() async {
    
  }
  
}