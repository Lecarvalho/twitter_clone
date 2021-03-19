import 'package:twitter_clone/models/profile_model.dart';
import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/services/profile_service_base.dart';
import 'package:twitter_clone/services/user_service_base.dart';

import 'controller_base.dart';

class UserController extends ControllerBase<UserServiceBase> {
  ProfileServiceBase profileService;

  late ProfileModel _myProfile;
  ProfileModel get myProfile => _myProfile;

  UserController({required service, required this.profileService})
      : super(service: service);

  Future<MyProfileResponse> createOrSignInWithGoogle() async {
    MyProfileResponse response;
    try {
      var userServiceResponse = await service.createOrSignInWithGoogle();
      if (userServiceResponse.success) {
        response = await _createNewProfileIfNeeded(userServiceResponse);
      } else {
        response = MyProfileResponse(
          message: userServiceResponse.message,
          type: ProfileStatusType.error,
        );
      }
    } catch (e) {
      response = MyProfileResponse(
        message: UserServiceResponseMessage.general_error,
        type: ProfileStatusType.error,
      );
      print(
          "error in User2Controller.createOrSignInWithGoogle - ${e.toString()}");
    }

    return response;
  }

  Future<MyProfileResponse> createWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    MyProfileResponse response;
    try {
      if (!UserModel.checkFields(email, password, name)) {
        return MyProfileResponse(
          message:
              "Invalid information. Please verify all the fields and try again.",
          type: ProfileStatusType.error,
        );
      }

      var userServiceResponse = await service.createWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );

      if (userServiceResponse.success) {
        _myProfile = await profileService.createProfile(
          userServiceResponse.user!.uid,
          ProfileModel.getMapForCreateProfile(
            id: userServiceResponse.user!.uid,
            name: userServiceResponse.user!.displayName,
            createdAt: DateTime.now().toUtc(),
          ),
        );

        response = MyProfileResponse(
          message: userServiceResponse.message,
          type: ProfileStatusType.incomplete,
        );
      }
      else {
        response = MyProfileResponse(
          message: userServiceResponse.message,
          type: ProfileStatusType.error,
        );
      }
    } catch (e) {
      print(
          "error in User2Controller.createWithEmailAndPassword - ${e.toString()}");
      response = MyProfileResponse(
        message: UserServiceResponseMessage.general_error,
        type: ProfileStatusType.error,
      );
    }
    return response;
  }

  Future<MyProfileResponse> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      if (!UserModel.isValidEmailPassword(email, password)) {
        return MyProfileResponse(
          message:
              "Invalid information. Please verify all the fields and try again.",
          type: ProfileStatusType.error,
        );
      }

      var userServiceResponse = await service.signInWithEmailAndPassword(
        email,
        password,
      );

      if (userServiceResponse.success) {
        return await _createNewProfileIfNeeded(userServiceResponse);
      }

      return MyProfileResponse(
        message: userServiceResponse.message,
        type: ProfileStatusType.error,
      );
    } catch (e) {
      print(
          "error in User2Controller.signInWithEmailAndPassword - ${e.toString()}");
      return MyProfileResponse(
        message: UserServiceResponseMessage.general_error,
        type: ProfileStatusType.error,
      );
    }
  }

  Future<ProfileModel?> _tryGetProfile(String id) async {
    return await profileService.getProfile(id);
  }

  Future<MyProfileResponse> _createNewProfileIfNeeded(
    UserServiceResponse userServiceResponse,
  ) async {
    var _profile = await _tryGetProfile(userServiceResponse.user!.uid);
    if (_profile == null) {
      _profile = await profileService.createProfile(
        userServiceResponse.user!.uid,
        ProfileModel.getMapForCreateProfile(
          id: userServiceResponse.user!.uid,
          name: userServiceResponse.user!.displayName,
          createdAt: DateTime.now().toUtc(),
        ),
      );
    }

    _myProfile = _profile;

    return MyProfileResponse(
      message: userServiceResponse.message,
      type: _myProfile.isProfileComplete
          ? ProfileStatusType.complete
          : ProfileStatusType.incomplete,
    );
  }

  Future<void> signOut() async {
    try {
      service.signOut();
    } catch (e) {
      print("Error on signOut: ${e.toString()}");
    }
  }

  Future<MyProfileResponse> tryAutoSigIn() async {
    try {
      var userServiceResponse = await service.tryAutoSigIn();

      if (userServiceResponse.success) {
        return await _createNewProfileIfNeeded(userServiceResponse);
      }

      return MyProfileResponse(
        message: userServiceResponse.message,
        type: ProfileStatusType.error,
      );
    } catch (e) {
      print("Error on tryAutoSigIn: ${e.toString()}");
      return MyProfileResponse(
        message: UserServiceResponseMessage.general_error,
        type: ProfileStatusType.error,
      );
    }
  }
}

class MyProfileResponse {
  String message;
  ProfileStatusType type;

  MyProfileResponse({required this.message, required this.type});
}

enum ProfileStatusType { complete, incomplete, error }
