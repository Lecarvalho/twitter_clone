import 'package:twitter_clone/models/user_model.dart';

import 'service_base.dart';

abstract class ProfileServiceBase extends ServiceBase {
  Future<UserModel> getUserProfile(String userId);
}