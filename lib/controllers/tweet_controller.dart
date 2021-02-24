import 'package:flutter/material.dart';
import 'package:twitter_clone/controllers/controller_base.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/services/tweets_service_base.dart';

class TweetController extends ControllerBase<TweetsServiceBase> {
  TweetController({@required service}) : super(service: service);

  Future<List<TweetModel>> getTweets() async {
    try {
      return await service.getTweets();
    } catch (e) {
      print("Error on getTweets: " + e);
    }

    return null;
  }

  Future<List<TweetModel>> getUserTweets(String userId) async {
    try {
      return await service.getUserTweets(userId);
    } catch (e) {
      print("Error on getUserTweets: " + e);
    }

    return null;
  }

  Future<void> createTweet(String text, String myUserId) async {
    try {
      var tweetModel = TweetModel.toMap(
        text: text,
        userId: myUserId,
        creationDate: DateTime.now(),
      );

      await service.createTweet(tweetModel);
    } catch (e) {
      print("Error on createTweet: " + e);
    }
  }
}
