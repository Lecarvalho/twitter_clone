import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/models/tweet_reaction_model.dart';
import 'package:twitter_clone/services/feed_service_base.dart';

import 'controller_base.dart';

class FeedController extends ControllerBase<FeedServiceBase> {
  FeedController({required service}) : super(service: service);

  final _notifier = StreamController<bool>();

  StreamSubscription<bool>? _streamForView;
  // ignore: cancel_subscriptions
  StreamSubscription? _streamFeedResponse;

  Map<String, TweetModel> _shownTweets = {};
  Map<String, TweetModel> _allTweets = {};
  Map<String, StreamSubscription> _listeningTweetsIds = {};

  List<TweetModel> get tweets => _shownTweets.values.toList().sortByCreatedAt();

  void listenFeed(String myProfileId, Function(bool) onData) async {
    if (_streamFeedResponse != null) {
      clearAllListeners();
    } else {
      _streamForView = _notifier.stream.listen((_) {});
    }

    _streamForView?.onData(onData);

    _streamFeedResponse = await service.streamFeed(
        myProfileId, (feedResponse) => onListenFeed(feedResponse, myProfileId));
  }

  void onListenFeed(FeedUpdateResponse feedResponse, String myProfileId) {
    if (feedResponse.commingTweets.isNotEmpty) {
      _listenTweetsComming(feedResponse.commingTweets, myProfileId);
    }

    if (feedResponse.deletedTweetsIds.isNotEmpty) {
      _removeTweetsFromAllTweetsMap(feedResponse.deletedTweetsIds);
    }

    if (feedResponse.commingTweets.isEmpty &&
        feedResponse.deletedTweetsIds.isEmpty) {
      _notifyView(asksToRefresh: false);
    }
  }

  void refreshShownTweets() {
    _shownTweets = Map.from(_allTweets);
  }

  Future<void> clearAllListeners() async {
    await _streamFeedResponse!.cancel();
    for (var streamSub in _listeningTweetsIds.values) {
      await streamSub.cancel();
    }
    _allTweets.clear();
    _shownTweets.clear();
    _listeningTweetsIds.clear();
  }

  void _listenTweetsComming(Map<String, TweetReactionModel?> commingTweets,
      String myProfileId) async {
    final alreadyListeningTweetsIds =
        Set<String>.from(_listeningTweetsIds.keys);
    final listenToTweetsIds = Set<String>.from(commingTweets.keys);
    final notListeningYetToTweetsIds = listenToTweetsIds
      ..removeWhere((tweetId) => alreadyListeningTweetsIds.contains(tweetId));

    for (var tweetId in notListeningYetToTweetsIds) {
      // ignore: cancel_subscriptions
      final streamSubs =
          await service.streamTweet(tweetId, myProfileId, (tweet) {
        if (tweet != null) {
          tweet.tweetReaction = commingTweets[tweetId];
          final isNewTweet = _addOrUpdateTweetOnAllTweetsMap(tweet);
          if (_hasAllTweetsFinishedLoading()) {
            final asksToRefresh = _shownTweets.isNotEmpty &&
                isNewTweet &&
                tweet.profileId != myProfileId;
            _notifyView(asksToRefresh: asksToRefresh);
          }
        }
      });

      _listeningTweetsIds.putIfAbsent(tweetId, () => streamSubs);
    }
  }

  void _notifyView({required bool asksToRefresh}) {
    _notifier.add(asksToRefresh);
  }

  bool _addOrUpdateTweetOnAllTweetsMap(TweetModel tweet) {
    bool isNewTweet;
    if (_allTweets.containsKey(tweet.id)) {
      _allTweets.update(tweet.id, (_) => tweet);
      isNewTweet = false;
    } else {
      _allTweets.putIfAbsent(tweet.id, () => tweet);
      isNewTweet = true;
    }
    return isNewTweet;
  }

  void _removeTweetsFromAllTweetsMap(Set<String> tweetsId) async {
    for (var tweetId in tweetsId) {
      _allTweets.remove(tweetId);
      _listeningTweetsIds[tweetId]!.cancel();
      _listeningTweetsIds.remove(tweetId);
    }
    _notifyView(asksToRefresh: true);
  }

  bool _hasAllTweetsFinishedLoading() {
    final allTweetsIdsOrdered = _allTweets.values
        .toList()
        .sortByCreatedAt()
        .map((tweet) => tweet.id)
        .toSet();

    return setEquals(_listeningTweetsIds.keys.toSet(), allTweetsIdsOrdered);
  }
}
