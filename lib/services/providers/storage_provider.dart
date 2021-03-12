import 'package:firebase_storage/firebase_storage.dart';
import 'package:twitter_clone/services/providers/service_provider_base.dart';

class StorageProvider extends ServiceProviderBase {

  late FirebaseStorage fireStorage;

  @override
  Future<void> init() async {
    fireStorage = FirebaseStorage.instance;
  }
  
}