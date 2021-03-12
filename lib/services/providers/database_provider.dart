import 'package:cloud_firestore/cloud_firestore.dart';
import 'service_provider_base.dart';

class DatabaseProvider extends ServiceProviderBase {

  late FirebaseFirestore firestore;

  @override
  Future<void> init() async {
    firestore = FirebaseFirestore.instance;
  }
}