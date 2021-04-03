import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/models/tweet_reaction_model.dart';
import 'package:twitter_clone/services/providers/database_provider.dart';

import 'feed_service_base.dart';

class FeedService extends FeedServiceBase {
  late DatabaseProvider _database;
  Collections get _collections => _database.collections;

  FeedService(DatabaseProvider provider) : super(provider) {
    _database = provider;
  }

  @override
  Stream<FeedUpdateResponse> listenFeed(String myProfileId) async* {
    final myFeedStreamSnapshot = _collections.feed
        .where(Fields.concernedProfileId, isEqualTo: myProfileId)
        .orderBy(Fields.createdAt, descending: true)
        .limit(20)
        .snapshots();

    await for (var myFeedSnapshoot in myFeedStreamSnapshot) {
      yield await _toListTweetModel(myFeedSnapshoot, myProfileId);
    }
  }

  @override
  Stream<TweetModel> listenTweetChanges(String tweetId) async* {
    final tweetStreamSnapshot = _collections.tweets.doc(tweetId).snapshots();

    await for (var tweetSnapshot in tweetStreamSnapshot) {
      if (tweetSnapshot.exists) {
        var tweet = await tweetSnapshot.reference.toModel<TweetModel>(
          (tweetMap) => TweetModel.fromMap(tweetMap),
        );
        yield tweet!;
      }
    }
  }

  Future<FeedUpdateResponse> _toListTweetModel(
    QuerySnapshot snapshot,
    String myProfileId,
  ) async {
    List<TweetModel> changedTweets = [];
    List<String> deletedTweetsIds = [];
    for (var feedDoc in snapshot.docChanges) {
      final feedMap = feedDoc.doc.data();
      final tweetId = feedMap![Fields.tweetId];

      if (feedDoc.newIndex != -1) {
        //updated
        final tweet = await _toTweetModel(tweetId, feedMap, myProfileId);
        if (tweet != null) changedTweets.add(tweet);
      } else {
        // deleted from feed, check if it was not just an undo reaction
        var previousFeedRef = await _collections.feed
            .where(Fields.concernedProfileId, isEqualTo: myProfileId)
            .where(Fields.tweetId, isEqualTo: tweetId)
            .orderBy(Fields.createdAt, descending: true)
            .limit(1)
            .toMapList();

        if (previousFeedRef.isNotEmpty) {
          final tweet =
              await _toTweetModel(tweetId, previousFeedRef.first, myProfileId);
          if (tweet != null) changedTweets.add(tweet);
        } else {
          //it was really removed from the user's feed
          deletedTweetsIds.add(tweetId);
        }
      }
    }

    return FeedUpdateResponse(
      commingTweets: changedTweets,
      deletedTweetsIds: deletedTweetsIds,
    );
  }

  Future<TweetModel?> _toTweetModel(
    String tweetId,
    Map<String, dynamic> feedMap,
    String myProfileId,
  ) async {
    final tweet = await _collections.tweets.doc(tweetId).toModel<TweetModel>(
          (data) => TweetModel.fromMap(data),
        );

    if (tweet != null) {
      if (feedMap[Fields.reactedByProfileId] != null) {
        tweet.tweetReaction = TweetReactionModel.fromMap(feedMap);
      }

      await _getMyReactions(tweet, myProfileId);

      return tweet;
    }
  }

  Future<TweetModel> _getMyReactions(
      TweetModel tweet, String myProfileId) async {
    tweet.didILike = await _collections.reactions.docExists(
      _collections.toReactionKey(tweet.id, myProfileId, ReactionTypes.like),
    );

    tweet.didIRetweet = await _collections.reactions.docExists(
      _collections.toReactionKey(tweet.id, myProfileId, ReactionTypes.retweet),
    );

    return tweet;
  }
}
