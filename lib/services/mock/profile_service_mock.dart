import 'package:twitter_clone/models/user_model.dart';

import '../profile_service_base.dart';
import 'json_tools.dart';

class ProfileServiceMock implements ProfileServiceBase {
  @override
  Future<UserModel> getUserProfile(String userId) async {
    return await JsonTools.jsonToModel(
      "assets/json/profile.json",
      (Map<String, dynamic> data) => UserModel.fromMapProfile(data),
    );
  }
}
