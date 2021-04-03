import 'dart:async';

import 'package:flutter/material.dart';
import 'package:twitter_clone/config/app_debug.dart';
import 'package:twitter_clone/controllers/controller_base.dart';
import 'package:twitter_clone/models/profile_model.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/services/tweet_service_base.dart';

class TweetController extends ControllerBase<TweetServiceBase> {
  TweetController({required service}) : super(service: service);

  TweetModel? _selectedTweet;
  TweetModel? get selectedTweet => _selectedTweet;

  List<TweetModel>? _tweets;
  List<TweetModel>? get tweets => _tweets?.toList().sortByCreatedAt();

  // Map<String, TweetModel> _allTweetsMap = {};
  // Map<String, TweetModel>? _tweetsToShowMap;
  // List<String> _listeningTweetReactions = [];

  // Future<void> getTweets(String myProfileId) async {
  //   try {
  //     // _tweets = await service.getTweets(myProfileId);
  //     if (subscriptionFeed == null) {
  //       final streamFeed = _listenFeed(myProfileId);

  //       subscriptionFeed = streamFeed.listen((event) {});
  //     }
  //   } catch (e) {
  //     print("Error on getTweets: " + e.toString());
  //   }
  // }

  // ignore: cancel_subscriptions
  // StreamSubscription<TypeOfLoadingFeed>? subscriptionFeed;

  // Stream<TypeOfLoadingFeed> _listenFeed(String myProfileId) async* {
  //   //listen is there's changes on feed
  //   final streamFeedChange = service.listenFeed(myProfileId);

  //   await for (var feedChanges in streamFeedChange) {
  //     print(
  //         "feedChanges.changedTweets?.length: ${feedChanges.changedTweets?.length}");
  //     print(
  //         "feedChanges.deletedTweetIds?.length: ${feedChanges.deletedTweetIds?.length}");

  //     if (feedChanges.changedTweets != null) {
  //       List<TypeOfLoadingFeed> typesOfUpdate = [];

  //       for (var changedTweet in feedChanges.changedTweets!) {
  //         if (_allTweetsMap.containsKey(changedTweet.id)) {
  //           _allTweetsMap.update(changedTweet.id, (_) => changedTweet);
  //           typesOfUpdate.add(TypeOfLoadingFeed.updateFeed_dontAsk);
  //         } else {
  //           _allTweetsMap.putIfAbsent(changedTweet.id, () => changedTweet);
  //           typesOfUpdate.add(TypeOfLoadingFeed.askToUpdateFeed);
  //         }
  //       }

  //       if (_tweetsToShowMap == null) {
  //         print("first load");
  //         typesOfUpdate.add(TypeOfLoadingFeed.firstLoad_dontAsk);
  //         refreshFeed();
  //       }

  //       if (typesOfUpdate.contains(TypeOfLoadingFeed.firstLoad_dontAsk))
  //         yield TypeOfLoadingFeed.firstLoad_dontAsk;
  //       else if (typesOfUpdate.contains(TypeOfLoadingFeed.askToUpdateFeed))
  //         yield TypeOfLoadingFeed.askToUpdateFeed;
  //       else
  //         yield TypeOfLoadingFeed.updateFeed_dontAsk;
  //     }

  //     if (feedChanges.deletedTweetIds != null) {
  //       for (var deletedTweetId in feedChanges.deletedTweetIds!) {
  //         _allTweetsMap.remove(deletedTweetId);
  //         yield TypeOfLoadingFeed.askToUpdateFeed;
  //       }
  //     }
  //   }
  // }

  // Stream<void> listenTweetReactions(String tweetId) async* {
  //   final streamTweetReactions = service.listenReactions(tweetId);

  //   await for (var tweet in streamTweetReactions) {
  //     _tweetsToShowMap?.update(tweet.id, (_) => tweet);
  //     yield 1;
  //   }
  // }

  // void refreshFeed() {
  //   _tweetsToShowMap = Map.from(_allTweetsMap);

  //   if (_tweetsToShowMap != null) {
  //     for (var tweetId in _tweetsToShowMap!.keys) {
  //       if (!_listeningTweetReactions.contains(tweetId)) {
  //         _listeningTweetReactions.add(tweetId);
  //         final streamReactions = listenTweetReactions(tweetId);

  //         streamReactions.listen((event) {
  //           // notifyListeners();
  //         });
  //       }
  //     }
  //   }
  // }

  Future<void> getProfileTweets(
    String profileId,
    String myProfileId,
  ) async {
    try {
      _tweets = await service.getProfileTweets(profileId, myProfileId);
    } catch (e) {
      print("Error on getProfileTweets: " + e.toString());
    }

    return null;
  }

  Future<void> createTweet(String text, ProfileModel myProfile) async {
    try {
      await service.createTweet(TweetModel.getMapForCreateTweet(
        text: text,
        myProfile: myProfile,
        createdAt: DateTime.now().toUtc(),
      ));
    } catch (e) {
      print("Error on createTweet: " + e.toString());
    }
  }

  Future<void> getTweet(String tweetId, String myProfileId) async {
    try {
      _selectedTweet = await service.getTweet(tweetId, myProfileId);
    } catch (e) {
      print("Error on getTweet: " + e.toString());
    }
  }

  Future<void> toggleLikeTweet(
    TweetModel tweet,
    String myProfileId,
    String myProfileName,
  ) async {
    try {
      if (tweet.didILike) {
        // tweet.likeCount--;
        await service.unlikeTweet(tweet.id, tweet.profileId, myProfileId);
        // if (tweet.tweetReaction?.reactedByProfileId == myProfileId) {
        //   tweet.tweetReaction = null;
        // }
      } else {
        // tweet.likeCount++;
        await service.likeTweet(
          tweet.id,
          tweet.profileId,
          myProfileId,
          myProfileName,
        );
      }

      tweet.didILike = !tweet.didILike;
    } catch (e) {
      print("Error on toggleLikeTweet: " + e.toString());
    }
  }

  Future<void> retweet(
    TweetModel tweet,
    String myProfileId,
    String myProfileName,
  ) async {
    try {
      if (!tweet.didIRetweet) {
        // tweet.retweetCount++;
        await service.retweet(
          tweet.id,
          tweet.profileId,
          myProfileId,
          myProfileName,
        );
      }

      tweet.didIRetweet = true;
    } catch (e) {
      print("Error on retweet: " + e.toString());
    }
  }
}

// enum TypeOfLoadingFeed {
//   updateFeed_dontAsk,
//   firstLoad_dontAsk,
//   askToUpdateFeed,
// }
