import 'package:twitter_clone/models/my_session_model.dart';
import 'package:twitter_clone/services/my_session_service_base.dart';
import 'package:twitter_clone/services/mock/json_tools.dart';

class MySessionServiceMock implements MySessionServiceBase {
  @override
  Future<AuthResponse> signInWithGoogle() async {
    print("SignIn with Google!");

    var mySession = await JsonTools.jsonToModel<MySessionModel>(
      "assets/json/login.json",
      (data) => MySessionModel.fromMap(data),
    );

    if (mySession != null) {
      return AuthResponse(
        mySession: mySession,
        responseType: AuthResponseType.success,
      );
    } else {
      return AuthResponse(
        responseType: AuthResponseType.user_disabled,
      );
    }
  }

  @override
  Future<AuthResponse> tryConnect() async {
    print("Try connect");

    var mySession = await JsonTools.jsonToModel<MySessionModel>(
      "assets/json/login.json",
      (data) => MySessionModel.fromMap(data),
    );

    if (mySession != null) {
      return AuthResponse(
        mySession: mySession,
        responseType: AuthResponseType.success,
      );
    } else {
      return AuthResponse(
        responseType: AuthResponseType.general_error,
      );
    }
  }

  @override
  Future<void> follow(String myProfileId, String toFollowUserId) async {
    print("myProfileId $myProfileId");
    print("update followingCount +1");
    print("update toFollowUser followingCount +1");
    print("following $toFollowUserId");
  }

  @override
  Future<void> unfollow(String myProfileId, String toUnfollowUserId) async {
    print("myProfileId $myProfileId");
    print("update followingCount -1");
    print("update toUnfollowUserId followingCount -1");
    print("Unfollowing $toUnfollowUserId");
  }

  @override
  Future<AuthResponse> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    print("SignIn with email and password!");
    print("email $email");
    print("password $password");

    var mySession = await JsonTools.jsonToModel<MySessionModel>(
      "assets/json/login_emailpwd.json",
      (data) => MySessionModel.fromMap(data),
    );

    if (mySession != null) {
      return AuthResponse(
        mySession: mySession,
        responseType: AuthResponseType.success,
      );
    } else {
      return AuthResponse(
        responseType: AuthResponseType.general_error,
      );
    }
  }

  @override
  Future<void> signOff() async {
    print("Signoff!");
  }

  @override
  Future<CreateUserResponseType> createUserProfile(
      MySessionModel mySession, String password) async {
    print("name: ${mySession.myProfile.name}");
    print("email: ${mySession.email}");
    print("nickname: ${mySession.myProfile.nickname}");
    print("followingCount: ${mySession.followingCount}");
    print("followersCount: ${mySession.followersCount}");

    print("password: $password");

    return CreateUserResponseType.success;
  }

  @override
  Future<String> uploadAvatar(
    String myProfileId,
    String selectedImagePath,
  ) async {
    print("myProfileId: $myProfileId");
    print("selectedImagePath: $selectedImagePath");

    //return new picture url
    return "https://static.wikia.nocookie.net/adventuretimewithfinnandjake/images/3/3b/Jakesalad.png/revision/latest/scale-to-width-down/340?cb=20190807133015";
  }

  @override
  Future<void> updateProfile(String myProfileId, String bio) async {
    print("profileId: $myProfileId");
    print("bio: $bio");
  }
}
