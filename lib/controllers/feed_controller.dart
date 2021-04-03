import 'dart:async';

import 'package:twitter_clone/config/app_debug.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/services/feed_service_base.dart';

import 'controller_base.dart';

class FeedController extends ControllerBase<FeedServiceBase> {
  FeedController({required service}) : super(service: service);

  late StreamController<bool> notifier;

  void _declareEventsStreamController(){
    notifier = StreamController<bool>(
      onListen: () {
        print("on listen");
      },
      onCancel: () {
        print("on cancel");
      },
      onPause: () {
        print("on pause");
      },
      onResume: () {
        print("on resume");
      }
    );
  }
  
  Map<String, TweetModel> _shownTweets = {};
  Map<String, TweetModel> _allTweets = {};
  List<String> _listeningTweetIds = [];

  List<TweetModel> get tweets => _shownTweets.values.toList().sortByCreatedAt();

  void listenFeed(String myProfileId) {
    final streamFeedResponse = service.listenFeed(myProfileId);

    _declareEventsStreamController();

    streamFeedResponse.listen((feedResponse) {
      _buildFeed(feedResponse);
      if (_shownTweets.isEmpty) {
        refreshShownTweets();
        _notifyView(asksToRefresh: false);
      } else {
        _notifyView(asksToRefresh: true);
      }
      final tweetIdsComming =
          feedResponse.commingTweets.map((tweet) => tweet.id).toList();
      _listenTweetsComming(tweetIdsComming);
    });
  }

  void refreshShownTweets() {
    _shownTweets = Map.from(_allTweets);
  }

  void _listenTweetsComming(List<String> tweetIds) {
    final listeningTweetIds = List.from(_listeningTweetIds);
    final tweetIdsToListenChanges = List.from(tweetIds);
    final notListeningTweetIds = tweetIdsToListenChanges
      ..removeWhere((tweetId) => listeningTweetIds.contains(tweetId));

    for (var tweetId in notListeningTweetIds) {
      final streamTweet = service.listenTweetChanges(tweetId);

      streamTweet.listen((tweet) {
        _addOrUpdateTweetOnAllTweetsMap(tweet);
        _notifyView(asksToRefresh: false);
      });

      _listeningTweetIds.add(tweetId);
    }
  }

  void _buildFeed(FeedUpdateResponse feedResponse) {
    _addOrUpdateTweetsOnAllTweetsMap(feedResponse.commingTweets);
    _removeTweetsFromAllTweetsMap(feedResponse.deletedTweetsIds);
  }

  void _notifyView({required bool asksToRefresh}) {
    notifier.add(asksToRefresh);
  }

  void _addOrUpdateTweetsOnAllTweetsMap(List<TweetModel> tweets) {
    for (var tweet in tweets) {
      _addOrUpdateTweetOnAllTweetsMap(tweet);
    }
  }

  void _addOrUpdateTweetOnAllTweetsMap(TweetModel tweet){
    if (_allTweets.containsKey(tweet.id)) {
        _allTweets.update(tweet.id, (_) => tweet);
      } else {
        _allTweets.putIfAbsent(tweet.id, () => tweet);
      }
  }

  void _removeTweetsFromAllTweetsMap(List<String>? tweetsId) {
    if (tweetsId != null) {
      for (var tweetId in tweetsId) {
        _allTweets.remove(tweetId);
      }
    }
  }
}
