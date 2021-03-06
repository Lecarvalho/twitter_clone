import 'package:twitter_clone/models/profile_model.dart';
import 'package:twitter_clone/services/service_base.dart';

abstract class SearchServiceBase extends ServiceBase {
  Future<List<ProfileModel>?> searchProfiles(String searchTerm); 
}