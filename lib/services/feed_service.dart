import 'dart:async';

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
  Future<StreamSubscription> streamFeed(String myProfileId, Function(FeedUpdateResponse) onListen) async {
    final myFeedStreamSnapshot = _collections.feed
        .where(Fields.concernedProfileId, isEqualTo: myProfileId)
        .orderBy(Fields.createdAt, descending: true)
        .limit(20)
        .snapshots();

    return myFeedStreamSnapshot.listen((myFeedSnapshot) async {
      final feedUpdateResponse = await _getFeedItem(myFeedSnapshot, myProfileId);
      onListen(feedUpdateResponse);
    });
  }

  @override
  Future<StreamSubscription> streamTweet(
      String tweetId, String myProfileId, Function(TweetModel?) onListen) async {
    final tweetStreamSnapshot = _collections.tweets.doc(tweetId).snapshots();

    return tweetStreamSnapshot.listen((tweetSnapshot) async { 
      final tweet = await tweetSnapshot.reference.toModel<TweetModel>(
        (tweetMap) =>
            _getMyReactions(TweetModel.fromMap(tweetMap), myProfileId),
      );

      onListen(tweet);
    });
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
