import 'package:twitter_clone/controllers/controller_base.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/services/tweets_service_base.dart';

class TweetController extends ControllerBase<TweetsServiceBase> {
  TweetController({required service}) : super(service: service);

  TweetModel? _bigTweet;
  TweetModel? get bigTweet => _bigTweet;

  List<TweetModel>? _tweets;
  List<TweetModel>? get tweets => _tweets;

  Future<void> getTweets(String myProfileId) async {
    try {
      _tweets = await service.getTweets(myProfileId);
    } catch (e) {
      print("Error on getTweets: " + e.toString());
    }
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

      await service.createTweet(
        text: text,
        myProfileId: myProfileId,
        createdAt: DateTime.now(),
      );
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

  Future<void> toggleLikeTweet(
    TweetModel tweet,
    String myProfileId,
  ) async {
    try {
      if (tweet.didILike) {
        tweet.likeCount--;
        await service.unlikeTweet(tweet.id, tweet.profileId, myProfileId);
      } else {
        tweet.likeCount++;
        await service.likeTweet(tweet.id, tweet.profileId, myProfileId);
      }

      tweet.didILike = !tweet.didILike;
    } catch (e) {
      print("Error on toggleLikeTweet: " + e.toString());
    }
  }

  Future<void> retweet(
    TweetModel tweet,
    String myProfileId,
  ) async {
    try {
      if (!tweet.didIRetweet) {
        tweet.retweetCount++;
        await service.retweet(tweet.id, tweet.profileId, myProfileId);
      }

      tweet.didIRetweet = true;
    } catch (e) {
      print("Error on retweet: " + e.toString());
    }
  }
}
