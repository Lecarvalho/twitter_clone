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

  @override
  Future<CreateUserResponse> createUserProfile(UserModel userModel, String password) async {
    print("name: ${userModel.name}");
    print("email: ${userModel.emailAddress}");
    print("nickname: ${userModel.nickname}");
    print("password: $password");

    return CreateUserResponse.success;
  }
}
