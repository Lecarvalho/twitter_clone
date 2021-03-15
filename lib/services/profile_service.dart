import 'dart:io';

import 'package:twitter_clone/models/profile_model.dart';
import 'package:twitter_clone/services/providers/database_storage_provider.dart';

import 'profile_service_base.dart';
import 'providers/database_provider.dart';
import 'providers/storage_provider.dart';

class ProfileService extends ProfileServiceBase {
  late StorageProvider _storage;
  late DatabaseProvider _database;

  ProfileService(DatabaseStorageProvider provider) : super(provider) {
    _storage = provider.storage;
    _database = provider.database;
  }

  @override
  Future<bool> isNicknameAvailable(String nickname) async {
    final profilesFound = await _database.collections.profiles
        .where("nickname", isEqualTo: nickname)
        .get();

    return profilesFound.docs.isEmpty;
  }

  @override
  Future<ProfileModel> createProfile(
    String id,
    Map<String, dynamic> profileMap,
  ) async {
    final profileRef = _database.collections.profiles.doc(id);
    await profileRef.set(profileMap);

    final myProfile = await profileRef.toModel<ProfileModel>(
      (data) => ProfileModel.fromCreation(data),
    );

    if (myProfile == null)
      throw Exception("Profile doesn't exists after creation. id: $id");

    return myProfile;
  }

  @override
  Future<void> follow(String myProfileId, String toFollowProfileId) async {
    final batch = _database.firestore.batch();
    final startingAt = DateTime.now().toUtc();
    final myFollowingListRef = _database.collections.following.doc(myProfileId);
    final myProfileRef = _database.collections.profiles.doc(myProfileId);
    final toFollowProfileRef =
        _database.collections.profiles.doc(toFollowProfileId);
    final toFollowFollowersRef =
        _database.collections.followers.doc(toFollowProfileId);

    //1. insert a new entry in my following collection
    final myFollowingList = await myFollowingListRef.toMap();

    if (myFollowingList == null) {
      // your new follwing !
      batch.set(myFollowingListRef, {toFollowProfileId: startingAt});
    } else {
      // one more person to follow !
      myFollowingList.putIfAbsent(toFollowProfileId, () => startingAt);
      batch.update(myFollowingListRef, myFollowingList);
    }

    //2. update the following count on my profile
    batch.update(
        myProfileRef, {Fields.followingCount: myFollowingList?.length ?? 1});

    //3. insert a new entry on the following follower collection
    final toFollowFollowerList = await toFollowFollowersRef.toMap();

    // maybe you are the first one that's following him/she
    if (toFollowFollowerList == null) {
      batch.set(toFollowFollowersRef, {myProfileId: startingAt});
    } else {
      // or maybe he/she is famous :)
      toFollowFollowerList.putIfAbsent(myProfileId, () => startingAt);
      batch.update(toFollowFollowersRef, toFollowFollowerList);
    }

    //4. update the follower count on the following profile
    batch.update(toFollowProfileRef,
        {Fields.followerCount: toFollowFollowerList?.length ?? 1});

    await batch.commit();
  }

  @override
  Future<void> unfollow(String myProfileId, String toUnfollowProfileId) async {
    final batch = _database.firestore.batch();
    final myFollowingListRef = _database.collections.following.doc(myProfileId);
    final myProfileRef = _database.collections.profiles.doc(myProfileId);
    final toUnfollowProfileRef =
        _database.collections.profiles.doc(toUnfollowProfileId);
    final toUnfollowFollowersRef =
        _database.collections.followers.doc(toUnfollowProfileId);

    //1. remove the entry on my following list
    final myFollowingList = await myFollowingListRef.toMap();

    myFollowingList!.remove(toUnfollowFollowersRef);
    batch.set(myFollowingListRef, myFollowingList);

    //2. update the following count on my profile
    batch.update(myProfileRef, {Fields.followingCount: myFollowingList.length});

    //3. remove the entry on the ex-following follower collection
    final toUnfollowFollowerList = await toUnfollowFollowersRef.toMap();

    toUnfollowFollowerList!.remove(myProfileId);

    //4. update the follower count on the ex-following profile
    batch.update(toUnfollowProfileRef,
        {Fields.followerCount: toUnfollowFollowerList.length});

    await batch.commit();
  }

  @override
  Future<ProfileModel?> getProfile(String id) async {
    return await _database.collections.profiles
        .doc(id)
        .toModel<ProfileModel>((data) => ProfileModel.fromFullInfo(data));
  }

  @override
  Future<ProfileModel> updateProfile(
    String id,
    Map<String, dynamic> profileMap,
  ) async {
    final profileRef = _database.collections.profiles.doc(id);

    await profileRef.update(profileMap);

    final profileModel = await profileRef
        .toModel<ProfileModel>((data) => ProfileModel.fromFullInfo(data));

    if (profileModel == null)
      throw Exception(
          "Trying to update a profile that doesn't exists. id: $id");

    return profileModel;
  }

  @override
  Future<String> uploadAvatar(String selectedImagePath, String filename) async {
    final file = File(selectedImagePath);

    var task = await _storage.fireStorage
        .ref("profiles/avatars/$filename")
        .putFile(file);

    return await task.ref.getDownloadURL();
  }
}
