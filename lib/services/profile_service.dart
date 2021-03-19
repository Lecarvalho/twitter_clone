import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitter_clone/models/profile_model.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/services/providers/database_storage_provider.dart';

import 'profile_service_base.dart';
import 'providers/database_provider.dart';
import 'providers/storage_provider.dart';

class ProfileService extends ProfileServiceBase {
  late StorageProvider _storage;
  late DatabaseProvider _database;

  Collections get _collections => _database.collections;

  ProfileService(DatabaseStorageProvider provider) : super(provider) {
    _storage = provider.storage;
    _database = provider.database;
  }

  @override
  Future<bool> isNicknameAvailable(String nickname) async {
    final profilesFound = await _collections.profiles
        .where("nickname", isEqualTo: nickname)
        .get();

    return profilesFound.docs.isEmpty;
  }

  @override
  Future<ProfileModel> createProfile(
    String id,
    Map<String, dynamic> profileMap,
  ) async {
    final profileRef = _collections.profiles.doc(id);
    await profileRef.set(profileMap);

    final myProfile = await profileRef.toModel<ProfileModel>(
      (data) => ProfileModel.fromCreation(data),
    );

    if (myProfile == null)
      throw Exception("Profile doesn't exists after creation. id: $id");

    return myProfile;
  }

  @override
  Future<void> follow(String myProfileId, String otherProfileId) async {
    final batch = _database.firestore.batch();
    final startingAt = DateTime.now().toUtc();

    //1. insert a new entry in my following collection
    await _setFollowingCollection(
      batch: batch,
      forProfileId: myProfileId,
      otherProfileId: otherProfileId,
      startingAt: startingAt,
    );

    //2. insert a new entry on the following follower collection
    await _setFollowersCollection(
      batch: batch,
      forProfileId: otherProfileId,
      otherProfileId: myProfileId,
      startingAt: startingAt,
    );

    //3. I need some tweets on my feed
    await _takeSomeFeedFromFollowing(
      batch: batch,
      followingProfileId: otherProfileId,
      howMuchToTake: 2,
      toProfileId: myProfileId,
      startingAt: startingAt,
    );

    await batch.commit();
  }

  @override
  Future<void> unfollow(String myProfileId, String otherProfileId) async {
    final batch = _database.firestore.batch();

    //1. remove the entry on my following list
    await _removeFromFollowingCollection(
      batch: batch,
      forProfileId: myProfileId,
      otherProfileId: otherProfileId,
    );

    //3. remove the entry on the ex-following follower collection
    await _removeFromFollowersCollection(
      batch: batch,
      forProfileId: otherProfileId,
      otherProfileId: myProfileId,
    );

    await batch.commit();
  }

  Future<void> _setFollowingCollection(
      {required WriteBatch batch,
      required String forProfileId,
      required String otherProfileId,
      required DateTime startingAt}) async {
    final followingRef = _collections.following.doc(forProfileId);
    final followingMap = await followingRef.toMap() ?? Map<String, dynamic>();

    followingMap.putIfAbsent(otherProfileId, () => startingAt);
    batch.set(followingRef, followingMap);

    _updateFollowingCount(
      batch: batch,
      profileId: forProfileId,
      followingCount: followingMap.length,
    );
  }

  Future<void> _setFollowersCollection({
    required WriteBatch batch,
    required String forProfileId,
    required String otherProfileId,
    required DateTime startingAt,
  }) async {
    final followersRef = _collections.followers.doc(forProfileId);
    final followersMap = await followersRef.toMap() ?? Map<String, dynamic>();

    followersMap.putIfAbsent(otherProfileId, () => startingAt);
    batch.set(followersRef, followersMap);

    _updateFollowerCount(
      batch: batch,
      profileId: forProfileId,
      followerCount: followersMap.length,
    );
  }

  Future<void> _removeFromFollowingCollection({
    required WriteBatch batch,
    required String forProfileId,
    required String otherProfileId,
  }) async {
    final followingRef = _collections.following.doc(forProfileId);
    final followingMap = await followingRef.toMap();

    followingMap!.remove(otherProfileId);
    batch.set(followingRef, followingMap);

    _updateFollowingCount(
      batch: batch,
      profileId: forProfileId,
      followingCount: followingMap.length,
    );
  }

  Future<void> _removeFromFollowersCollection({
    required WriteBatch batch,
    required String forProfileId,
    required String otherProfileId,
  }) async {
    final followersRef = _collections.followers.doc(forProfileId);
    final followersMap = await followersRef.toMap();

    followersMap!.remove(otherProfileId);
    batch.set(followersRef, followersMap);

    _updateFollowerCount(
      batch: batch,
      profileId: forProfileId,
      followerCount: followersMap.length,
    );
  }

  void _updateFollowingCount({
    required WriteBatch batch,
    required String profileId,
    required int followingCount,
  }) {
    final profileRef = _collections.profiles.doc(profileId);
    batch.update(profileRef, {Fields.followingCount: followingCount});
  }

  void _updateFollowerCount({
    required WriteBatch batch,
    required String profileId,
    required int followerCount,
  }) {
    final profileRef = _collections.profiles.doc(profileId);
    batch.update(profileRef, {Fields.followerCount: followerCount});
  }

  Future<void> _takeSomeFeedFromFollowing({
    required String toProfileId,
    required String followingProfileId,
    required int howMuchToTake,
    required WriteBatch batch,
    required DateTime startingAt,
  }) async {
    final tweetsFromMyFollowing = await _collections.tweets
        .where(Fields.profileId, isEqualTo: followingProfileId)
        .limit(howMuchToTake)
        .toModelList<TweetModel>((data) => TweetModel.fromMap(data));

    for (var tweet in tweetsFromMyFollowing) {
      final newFeedRef = _collections.feed.doc(_collections.toFeedKey(tweet.id, toProfileId));
      batch.set(newFeedRef, {
        Fields.concernedProfileId: toProfileId,
        Fields.createdAt: startingAt,
        Fields.tweetId: tweet.id,
        Fields.creatorTweetProfileId: followingProfileId,
      });
    }
  }

  @override
  Future<ProfileModel?> getProfile(String id) async {
    return await _collections.profiles
        .doc(id)
        .toModel<ProfileModel>((data) => ProfileModel.fromFullInfo(data));
  }

  @override
  Future<ProfileModel> updateProfile(
    String id,
    Map<String, dynamic> profileMap,
  ) async {
    final profileRef = _collections.profiles.doc(id);

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

  @override
  Future<bool> amIFollowingProfile(
    String myProfileId,
    String otherProfileId,
  ) async {
    final followingMap = await _collections.following.doc(myProfileId).toMap();

    return followingMap?.containsKey(otherProfileId) ?? false;
  }
}
