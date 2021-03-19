import 'package:twitter_clone/models/profile_model.dart';

import 'providers/database_provider.dart';
import 'search_service_base.dart';

class SearchService extends SearchServiceBase {
  late DatabaseProvider _database;
  SearchService(DatabaseProvider provider) : super(provider) {
    _database = provider;
  }

  @override
  Future<List<ProfileModel>?> searchProfiles(String searchTerm) async {
    return await _database.collections.profiles
        .orderBy(Fields.nameSearch)
        .where(Fields.nameSearch, isGreaterThanOrEqualTo: searchTerm)
        .where(Fields.nameSearch, isLessThanOrEqualTo: searchTerm + "\uf88ff")
        .toModelList<ProfileModel>((data) => ProfileModel.fromBasicInfo(data));
  }
}
