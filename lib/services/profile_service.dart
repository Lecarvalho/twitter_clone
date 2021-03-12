import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitter_clone/models/profile_model.dart';
import 'package:twitter_clone/services/providers/database_storage_provider.dart';
import 'package:twitter_clone/services/providers/storage_provider.dart';

import 'profile_service_base.dart';

class ProfileService extends ProfileServiceBase {
  late Collections _collections;
  late StorageProvider _storage;

  ProfileService(DatabaseStorageProvider provider) : super(provider) {
    _collections = Collections(provider.database.firestore);
    _storage = provider.storage;
  }

  @override
  Future<bool> isNicknameAvailable(String nickname) async {
    final profilesFound = await _collections.profiles
        .where("nickname", isEqualTo: nickname)
        .get();

    return profilesFound.docs.isEmpty;
  }

  @override
  Future<ProfileModel> createProfile(String id, String name, DateTime createdAt) async {
    await _collections.profiles.doc(id).set({
      "id": id,
      "name": name,
      "createdAt": createdAt.toString(),
    });

    final myProfileMap = await _getMyProfileMap(id);

    if (myProfileMap == null)
      throw Exception(
          "Profile doesn't exists after creation. id: $id");

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
    final myProfileMap = await _getMyProfileMap(id);

    if (myProfileMap == null)
      return null;

    return ProfileModel.fromFullInfo(myProfileMap);
  }

  @override
  Future<ProfileModel> updateProfile(ProfileModel profile) async {
    final myProfileDoc = await _getMyProfileDoc(profile.id);

    await myProfileDoc.reference.update(profile.getMapForChangeableFields());

    final myProfileMap = await _getMyProfileMap(profile.id);

    if (myProfileMap == null)
      throw Exception(
          "Trying to update a profile that doesn't exists. id: ${profile.id}");

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

  Future<Map<String, dynamic>?> _getMyProfileMap(
    String myProfileId,
  ) async {
    return (await _getMyProfileDoc(myProfileId)).data();
  }

  Future<DocumentSnapshot> _getMyProfileDoc(String myProfileId) async {
    return await _collections.profiles.doc(myProfileId).get();
  }

  Future<void> _toggleFollowingUnfollowing(
    String myProfileId,
    String toFollowOrUnfollowProfileId,
  ) async {
    final myProfileDoc = await _getMyProfileDoc(myProfileId);
    final myProfileMap = myProfileDoc.data();

    if (myProfileMap == null)
      throw Exception(
          "Trying to follow or unfollow someone but my profile doesn't exists. id: $myProfileId");

    final following = myProfileMap["following"] != null
        ? List.from(myProfileMap["following"])
        : List.empty();

    following.contains(toFollowOrUnfollowProfileId)
        ? following.remove(toFollowOrUnfollowProfileId)
        : following.add(toFollowOrUnfollowProfileId);

    await myProfileDoc.reference.update({"following": following});
  }
}

class Collections {
  FirebaseFirestore _firestore;
  Collections(this._firestore);

  CollectionReference get profiles => _firestore.collection('profiles');
}
