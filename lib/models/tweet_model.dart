import 'package:intl/intl.dart';

import 'profile_model.dart';

class TweetModel {
  TweetModel({
    this.profileModel,
    this.tweetText,
    this.dateTimeTweet,
  });

  ProfileModel profileModel;
  String tweetText;
  DateTime dateTimeTweet;
  String get dateLong => DateFormat.Hm().add_yMd().format(dateTimeTweet);
  String get dateShort =>
      getDifferenceInDaysOrHoursFromTweetToNow(dateTimeTweet, DateTime.now());

  String getDifferenceInDaysOrHoursFromTweetToNow(
      DateTime dateTimeTweet, DateTime now) {
    var difference = dateTimeTweet.difference(now);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return (difference.inMinutes * -1).toString() + "m";
      }
      return (difference.inHours * -1).toString() + "h";
    }
    return (difference.inDays * -1).toString() + "d";
  }
}
