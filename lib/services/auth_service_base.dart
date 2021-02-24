import 'package:twitter_clone/models/user_model.dart';

import 'service_base.dart';

abstract class AuthServiceBase extends ServiceBase {
  Future<UserModel> sigInWithGoogle();
  Future<UserModel> tryConnect();
}