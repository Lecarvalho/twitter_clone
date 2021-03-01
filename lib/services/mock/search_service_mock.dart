import 'package:twitter_clone/models/profile_model.dart';

import '../search_service_base.dart';
import 'json_tools.dart';

class SearchServiceMock implements SearchServiceBase {
  @override
  Future<List<ProfileModel>> searchProfiles(String searchTerm) async {
    var profiles = await JsonTools.jsonToModelList<ProfileModel>(
      "assets/json/profiles.json",
      (data) => ProfileModel.fromMapSingleTweet(data),
    );

    return profiles.where((ProfileModel profile) =>
        profile.name.toLowerCase().startsWith(searchTerm) ||
        profile.nickname.toLowerCase().startsWith(searchTerm)).toList();
  }
}
