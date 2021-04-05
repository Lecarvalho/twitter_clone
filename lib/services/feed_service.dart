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
      yield await _getFeedItem(myFeedSnapshoot, myProfileId);
    }
  }

  @override
  Stream<TweetModel?> listenTweetChanges(
      String tweetId, String myProfileId) async* {
    final tweetStreamSnapshot = _collections.tweets.doc(tweetId).snapshots();

    await for (var tweetSnapshot in tweetStreamSnapshot) {
      var tweet = await tweetSnapshot.reference.toModel<TweetModel>(
        (tweetMap) =>
            _getMyReactions(TweetModel.fromMap(tweetMap), myProfileId),
      );
      yield tweet;
    }
  }

  Future<FeedUpdateResponse> _getFeedItem(
    QuerySnapshot snapshot,
    String myProfileId,
  ) async {
    Map<String, TweetReactionModel?> commingTweets = {};
    Set<String> deletedTweetsIds = {};
    for (var feedDoc in snapshot.docChanges) {
      final feedMap = feedDoc.doc.data();
      final tweetId = feedMap![Fields.tweetId];
      TweetReactionModel? tweetReaction;

      if (feedMap[Fields.reactedByProfileId] != null) {
        tweetReaction = TweetReactionModel.fromMap(feedMap);
      }

      if (feedDoc.newIndex != -1) {
        //created or updated
        commingTweets.putIfAbsent(tweetId, () => tweetReaction);
      } else {
        // deleted from feed, check if it was not just an undo reaction
        var previousFeedRef = await _collections.feed
            .where(Fields.concernedProfileId, isEqualTo: myProfileId)
            .where(Fields.tweetId, isEqualTo: tweetId)
            .orderBy(Fields.createdAt, descending: true)
            .limit(1)
            .toMapList();

        if (previousFeedRef.isNotEmpty) {
          commingTweets.putIfAbsent(tweetId, () => tweetReaction);
        } else {
          //it was really removed from the user's feed
          deletedTweetsIds.add(tweetId);
        }
      }
    }

    return FeedUpdateResponse(
      commingTweets: commingTweets,
      deletedTweetsIds: deletedTweetsIds,
    );
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
