import 'package:twitter_clone/models/profile_model.dart';
import 'package:twitter_clone/services/search_service_base.dart';

import 'controller_base.dart';

class SearchController extends ControllerBase<SearchServiceBase> {
  SearchController({required service}) : super(service: service);

  List<ProfileModel>? _profilesFound;
  List<ProfileModel>? get profilesFound => _profilesFound;
  bool get foundSomething => (_profilesFound?.length ?? 0) > 0;

  Future<void> searchProfiles(String searchTerm) async {

    if (searchTerm.isNotEmpty) {

      var _searchTerm = searchTerm.toLowerCase();

      _profilesFound = await service.searchProfiles(_searchTerm);
    }
    else {
      _profilesFound = null;
    }
  }
}
