import 'package:flutter/foundation.dart';
import 'package:twitter_clone/controllers/controller_base.dart';
import 'package:twitter_clone/models/profile_model.dart';
import 'package:twitter_clone/services/profile_service_base.dart';

class ProfileController extends ControllerBase<ProfileServiceBase> {
  ProfileController({@required service}) : super(service: service);

  ProfileModel get profile => _profile;
  ProfileModel _profile;

  Future<void> getProfile(String profileId) async {
    try {
      _profile = await service.getProfile(profileId);
    } catch (e) {
      print("Error on getProfile: " + e);
    }
  }
}