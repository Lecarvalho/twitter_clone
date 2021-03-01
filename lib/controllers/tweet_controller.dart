import 'package:flutter/material.dart';
import 'package:twitter_clone/controllers/controller_base.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/services/tweets_service_base.dart';

class TweetController extends ControllerBase<TweetsServiceBase> {
  TweetController({@required service}) : super(service: service);

  TweetModel _bigTweet;
  TweetModel get bigTweet => _bigTweet; 

  List<TweetModel> _tweets;
  List<TweetModel> get tweets => _tweets;

  Future<void> getTweets() async {
    try {
      _tweets = await service.getTweets();
    } catch (e) {
      print("Error on getTweets: " + e.toString());
    }

    return null;
  }

  Future<void> getProfileTweets(String profileId) async {
    try {
      _tweets = await service.getProfileTweets(profileId);
    } catch (e) {
      print("Error on getProfileTweets: " + e.toString());
    }

    return null;
  }

  Future<void> createTweet(String text, String myProfileId) async {
    try {
      var tweetModel = TweetModel.toMap(
        text: text,
        profileId: myProfileId,
        creationDate: DateTime.now(),
      );

      await service.createTweet(tweetModel);
    } catch (e) {
      print("Error on createTweet: " + e.toString());
    }
  }

  Future<void> getTweet(String tweetId) async {
    try {
      _bigTweet = await service.getTweet(tweetId);
    } catch (e) {
      print("Error on getTweet: " + e.toString());
    }
  }
}
