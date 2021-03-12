import 'package:twitter_clone/services/providers/database_provider.dart';
import 'package:twitter_clone/services/providers/storage_provider.dart';

import 'service_provider_base.dart';

class DatabaseStorageProvider extends ServiceProviderBase {
  
  DatabaseProvider database;
  StorageProvider storage;

  DatabaseStorageProvider(this.database, this.storage);

  @override
  Future<void> init() async {
  }
  
}