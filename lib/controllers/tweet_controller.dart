import 'package:flutter/material.dart';
import 'package:twitter_clone/controllers/controller_base.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/services/tweets_service_base.dart';

class TweetController extends ControllerBase<TweetsServiceBase> {
  TweetController({@required service}) : super(service: service);

  Future<List<TweetModel>> getTweets() async {
    return await service.getTweets();
  }

  Future<List<TweetModel>> getUserTweets(String userId) async {
    return await service.getUserTweets(userId);
  }
}