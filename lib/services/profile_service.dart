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
    await _database.collections.getProfileRef(id).set(profileMap);

    final myProfileMap = await _database.collections.getProfileMap(id);

    if (myProfileMap == null)
      throw Exception("Profile doesn't exists after creation. id: $id");

    return ProfileModel.fromCreation(myProfileMap);
  }

  @override
  Future<void> follow(String myProfileId, String toFollowUserId) async {
    await _toggleFollowingUnfollowing(myProfileId, toFollowUserId);
  }

  @override
  Future<void> unfollow(String myProfileId, String toUnfollowUserId) async {
    await _toggleFollowingUnfollowing(myProfileId, toUnfollowUserId);
  }

  @override
  Future<ProfileModel?> getProfile(String id) async {
    final myProfileMap = await _database.collections.getProfileMap(id);

    if (myProfileMap == null) return null;

    return ProfileModel.fromFullInfo(myProfileMap);
  }

  @override
  Future<ProfileModel> updateProfile(
    String id,
    Map<String, dynamic> profileMap,
  ) async {
    final myProfileRef = _database.collections.getProfileRef(id);

    await myProfileRef.update(profileMap);

    final myProfileMap = await _database.collections.getProfileMap(id);

    if (myProfileMap == null)
      throw Exception(
          "Trying to update a profile that doesn't exists. id: $id");

    return ProfileModel.fromFullInfo(myProfileMap);
  }

  @override
  Future<String> uploadAvatar(String selectedImagePath, String filename) async {
    final file = File(selectedImagePath);

    var task = await _storage.fireStorage
        .ref("profiles/avatars/$filename")
        .putFile(file);

    return await task.ref.getDownloadURL();
  }

  Future<void> _toggleFollowingUnfollowing(
    String myProfileId,
    String toFollowOrUnfollowProfileId,
  ) async {
    final myProfileRef = _database.collections.getProfileRef(myProfileId);
    final myProfileMap = (await myProfileRef.get()).data();

    if (myProfileMap == null)
      throw Exception(
          "Trying to follow or unfollow someone but my profile doesn't exists. id: $myProfileId");

    final following = myProfileMap["following"] != null
        ? List.from(myProfileMap["following"])
        : List.empty();

    following.contains(toFollowOrUnfollowProfileId)
        ? following.remove(toFollowOrUnfollowProfileId)
        : following.add(toFollowOrUnfollowProfileId);

    await myProfileRef.update({"following": following});
  }
}
