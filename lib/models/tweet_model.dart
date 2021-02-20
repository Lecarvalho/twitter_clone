import 'package:intl/intl.dart';

import 'user_model.dart';

class TweetModel {
  TweetModel({
    this.userModel,
    this.text,
    this.creationDate,
  });

  UserModel userModel;
  String text;
  DateTime creationDate;
  int heartCount;
  
  String get creationDateLong => DateFormat.Hm().add_yMd().format(creationDate);
  String get creationDateShort =>
      getDifferenceInDaysOrHoursFromTweetToNow(creationDate, DateTime.now());

  String getDifferenceInDaysOrHoursFromTweetToNow(
      DateTime creationDate, DateTime now) {
    var difference = creationDate.difference(now);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return (difference.inMinutes * -1).toString() + "m";
      }
      return (difference.inHours * -1).toString() + "h";
    }
    return (difference.inDays * -1).toString() + "d";
  }
}
