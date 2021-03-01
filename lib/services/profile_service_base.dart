import 'package:twitter_clone/models/profile_model.dart';

import 'service_base.dart';

abstract class ProfileServiceBase extends ServiceBase {
  Future<ProfileModel> getProfile(String profileId);
}

