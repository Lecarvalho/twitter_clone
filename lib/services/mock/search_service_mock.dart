import 'package:twitter_clone/models/user_model.dart';

import '../search_service_base.dart';
import 'json_tools.dart';

class SearchServiceMock implements SearchServiceBase {
  @override
  Future<List<UserModel>> searchProfiles(String searchTerm) async {
    var profiles = await JsonTools.jsonToModelList<UserModel>(
      "assets/json/profiles.json",
      (data) => UserModel.fromMapSingleTweet(data),
    );

    return profiles.where((UserModel profile) =>
        profile.name.toLowerCase().startsWith(searchTerm) ||
        profile.nickname.toLowerCase().startsWith(searchTerm)).toList();
  }
}
