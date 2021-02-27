import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/services/service_base.dart';

abstract class SearchServiceBase extends ServiceBase {
  Future<List<UserModel>> searchProfiles(String searchTerm); 
}