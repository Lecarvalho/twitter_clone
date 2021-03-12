import 'package:twitter_clone/models/profile_model.dart';
import 'package:twitter_clone/services/service_base.dart';
import 'package:twitter_clone/services/providers/service_provider_base.dart';

abstract class SearchServiceBase extends ServiceBase {
  SearchServiceBase(ServiceProviderBase provider) : super(provider);

  Future<List<ProfileModel>?> searchProfiles(String searchTerm); 
}