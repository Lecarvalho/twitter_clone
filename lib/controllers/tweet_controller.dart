import 'dart:async';

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
  bool _lockActionButton = false;

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

  void releaseActionButton() {
    _lockActionButton = false;
  }

  Future<void> toggleLikeTweet(
    TweetModel tweet,
    String myProfileId,
    String myProfileName,
  ) async {
    try {
      if (!_lockActionButton) {
        _lockActionButton = true;
        if (tweet.didILike) {
          tweet.likeCount--;
          await service.unlikeTweet(tweet.id, tweet.profileId, myProfileId);
        } else {
          tweet.likeCount++;
          await service.likeTweet(
            tweet.id,
            tweet.profileId,
            myProfileId,
            myProfileName,
          );
        }
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
      if (!_lockActionButton) {
        _lockActionButton = true;
        if (!tweet.didIRetweet) {
          await service.retweet(
            tweet.id,
            tweet.profileId,
            myProfileId,
            myProfileName,
          );
        }
      }
    } catch (e) {
      print("Error on retweet: " + e.toString());
    }
  }
}