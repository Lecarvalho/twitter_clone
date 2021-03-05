import 'package:twitter_clone/models/profile_model.dart';

import '../search_service_base.dart';
import 'mock_tools.dart';

class SearchServiceMock implements SearchServiceBase {
  @override
  Future<List<ProfileModel>> searchProfiles(String searchTerm) async {
    var profiles = await MockTools.jsonToModelList<ProfileModel>(
      "assets/json/profiles.json",
      (data) => ProfileModel.fromMapSingleTweet(data),
    );

    await MockTools.simulateQuickRequestDelay();

    return profiles.where((ProfileModel profile) =>
        profile.name.toLowerCase().startsWith(searchTerm) ||
        profile.nickname.toLowerCase().startsWith(searchTerm)).toList();
  }
}
