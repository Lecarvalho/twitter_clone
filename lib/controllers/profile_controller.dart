import 'package:flutter/foundation.dart';
import 'package:twitter_clone/controllers/controller_base.dart';
import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/services/profile_service_base.dart';

class ProfileController extends ControllerBase<ProfileServiceBase> {
  ProfileController({@required service}) : super(service: service);

  UserModel get profile => _profile;
  UserModel _profile;

  Future<void> getUserProfile(String userId) async {
    _profile = await service.getUserProfile(userId);
  }
}
