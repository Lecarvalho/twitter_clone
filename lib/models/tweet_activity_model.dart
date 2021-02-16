class TweetActivityModel {
  String profileName;
  TweetAction tweetAction;

  TweetActivityModel({
    this.profileName,
    this.tweetAction,
  });
}

enum TweetAction { liked, retweeted }
