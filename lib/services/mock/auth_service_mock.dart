import 'package:twitter_clone/models/auth_model.dart';
import 'package:twitter_clone/services/auth_service_base.dart';
import 'package:twitter_clone/services/mock/json_tools.dart';

class AuthServiceMock implements AuthServiceBase {
  @override
  Future<AuthModel> sigInWithGoogle() async {
    return await JsonTools.jsonToModel<AuthModel>(
      "assets/json/login.json",
      (data) => AuthModel.fromMap(data),
    );
  }

  @override
  Future<AuthModel> tryConnect() async {
   return await JsonTools.jsonToModel<AuthModel>(
      "assets/json/login.json",
      (data) => AuthModel.fromMap(data),
    );
  }
}
