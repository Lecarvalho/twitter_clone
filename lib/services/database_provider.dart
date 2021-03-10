import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'service_provider_base.dart';

class DatabaseProvider extends ServiceProviderBase {

  final firestore = FirebaseFirestore.instance;

  @override
  Future<void> init() async {
    await Firebase.initializeApp();
  }
}