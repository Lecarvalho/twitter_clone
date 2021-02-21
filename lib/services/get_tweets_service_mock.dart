import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/services/get_tweets_service_base.dart';

class GetTweetsServiceMock implements GetTweetsServiceBase {

  @override
  Future<List<TweetModel>> getTweets() async {
    var jsonTweets = await rootBundle.loadString("assets/json/tweets.json");
    var jsonUsers = await rootBundle.loadString("assets/json/users.json");

    var tweetsCollection = json.decode(jsonTweets);
    var listTweets = tweetsCollection.map((itemJson) => TweetModel.fromMap(itemJson));

    var usersCollection = json.decode(jsonUsers);
    var listUsers = usersCollection.map((itemJson) => UserModel.fromMapBasicInfo(itemJson));

    listTweets= listTweets.map((tweet) {
      var user = listUsers.firstWhere((user) => user.id == tweet.userId);
      tweet.userModel = user;
      return tweet;
    });

    return List<TweetModel>.from(listTweets);
  }
  
}