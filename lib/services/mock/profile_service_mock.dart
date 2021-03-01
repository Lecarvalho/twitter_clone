import 'package:twitter_clone/models/profile_model.dart';

import '../profile_service_base.dart';
import 'json_tools.dart';

class ProfileServiceMock implements ProfileServiceBase {
  @override
  Future<ProfileModel> getProfile(String profileId) async {

    var profiles = await JsonTools.jsonToModelList<ProfileModel>(
      "assets/json/profiles.json",
      (data) => ProfileModel.fromMapProfile(data),
    );

    return profiles.firstWhere((profile) => profile.id == profileId);
  }
}
