import 'package:twitter_clone/models/user_model.dart';

import '../profile_service_base.dart';
import 'json_tools.dart';

class ProfileServiceMock implements ProfileServiceBase {
  @override
  Future<UserModel> getUserProfile(String userId) async {

    var profiles = await JsonTools.jsonToModelList<UserModel>(
      "assets/json/profiles.json",
      (data) => UserModel.fromMapProfile(data),
    );

    return profiles.firstWhere((profile) => profile.id == userId);
  }
}
