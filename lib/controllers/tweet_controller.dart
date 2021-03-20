import 'package:twitter_clone/controllers/controller_base.dart';
import 'package:twitter_clone/models/profile_model.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/services/tweet_service_base.dart';

class TweetController extends ControllerBase<TweetServiceBase> {
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
      _bigTweet = await service.getTweet(tweetId, myProfileId);
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
        tweet.likeCount--;
        await service.unlikeTweet(tweet.id, tweet.profileId, myProfileId);
        if (tweet.tweetReaction?.reactedByProfileId == myProfileId){
          tweet.tweetReaction = null;
        }
      } else {
        tweet.likeCount++;
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
        tweet.retweetCount++;
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
