import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitter_clone/models/profile_model.dart';
import 'package:twitter_clone/models/reply_model.dart';
import 'package:twitter_clone/services/providers/database_provider.dart';

import 'reply_service_base.dart';

class ReplyService extends ReplyServiceBase {
  late final DatabaseProvider _database;
  CollectionReference _repliesCollection(String tweetId) {
    return _database.collections.tweets.doc(tweetId).collection("replies");
  }

  ReplyService(DatabaseProvider provider) : super(provider) {
    _database = provider;
  }

  @override
  Future<List<ReplyModel>?> getReplies(String tweetId) async {
    return await _repliesCollection(tweetId)
        .toModelList((data) => ReplyModel.fromMap(data));
  }

  @override
  Future<void> replyTweet({
    required String replyingToTweetId,
    required String text,
    required String myProfileId,
    required DateTime createdAt,
    required String replyingToProfileId,
  }) async {
    final batch = _database.firestore.batch();

    final repliesCollection = _repliesCollection(replyingToTweetId);

    final getReplierProfile = await _database.collections.profiles
        .doc(myProfileId)
        .toModel<ProfileModel>(
          (data) => ProfileModel.fromBasicInfo(data),
        );

    final tweetRef = _database.collections.tweets.doc(replyingToTweetId);

    final tweetMap = await tweetRef.toMap();

    var repliesCount = tweetMap![Fields.repliesCount] ?? 0;

    repliesCount++;

    batch.update(tweetRef, {
      Fields.repliesCount: repliesCount,
    });

    batch.set(repliesCollection.doc(), {
      Fields.text: text,
      Fields.profileId: myProfileId,
      Fields.createdAt: createdAt,
      Fields.replyingToTweetId: replyingToTweetId,
      Fields.replyingToProfileId: replyingToProfileId,
      Fields.profile: {
        Fields.id: getReplierProfile!.id,
        Fields.avatar: getReplierProfile.avatar,
        Fields.name: getReplierProfile.name,
        Fields.nickname: getReplierProfile.nickname,
      }
    });

    await batch.commit();
  }
}
