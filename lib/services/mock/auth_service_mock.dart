import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/services/auth_service_base.dart';
import 'package:twitter_clone/services/mock/json_tools.dart';

class AuthServiceMock implements AuthServiceBase {
  @override
  Future<UserModel> sigInWithGoogle() async {
    return await JsonTools.jsonToModel<UserModel>(
      "assets/json/profile.json",
      (data) => UserModel.fromMapProfile(data),
    );
  }

  @override
  Future<UserModel> tryConnect() async {
    return await JsonTools.jsonToModel<UserModel>(
      "assets/json/profile.json",
      (data) => UserModel.fromMapProfile(data),
    );
  }
}
