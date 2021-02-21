import 'package:flutter/material.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/services/get_tweets_service_base.dart';

class TweetController {

  GetTweetsServiceBase service;
  TweetController({@required this.service});

  Future<List<TweetModel>> getTweets() async {
    return await service.getTweets();
  }
}