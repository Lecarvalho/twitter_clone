import 'package:twitter_clone/models/auth_model.dart';

import 'service_base.dart';

abstract class AuthServiceBase extends ServiceBase {
  Future<AuthModel> sigInWithGoogle();
  Future<AuthModel> tryConnect();
}