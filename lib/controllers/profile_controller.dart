import 'package:flutter/foundation.dart';
import 'package:twitter_clone/controllers/controller_base.dart';
import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/services/profile_service_base.dart';

class ProfileController extends ControllerBase<ProfileServiceBase> {
  ProfileServiceBase service;
  ProfileController({@required this.service})
      : super(service: service);

  Future<UserModel> getUserProfile(String userId) async {
    return await service.getUserProfile(userId);
  }
}
