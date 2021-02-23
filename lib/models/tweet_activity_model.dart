import 'model_base.dart';

class TweetActivityModel extends ModelBase {
  String profileName;
  TweetAction tweetAction;

  TweetActivityModel({
    this.profileName,
    this.tweetAction,
  });
}

enum TweetAction { liked, retweeted }
