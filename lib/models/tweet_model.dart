import 'package:intl/intl.dart';

import 'model_base.dart';
import 'user_model.dart';

class TweetModel extends ModelBase {
  TweetModel({
    this.id,
    this.userId,
    this.userModel,
    this.text,
    this.creationDate,
    this.heartCount,
    this.commentCount,
    this.retweetCount,
  });

  UserModel userModel;
  String userId;
  String id;
  String text;
  DateTime creationDate;
  int heartCount;
  int commentCount;
  int retweetCount;

  String get creationDateLong => DateFormat.Hm().add_yMd().format(creationDate);
  String get creationTimeAgo =>
      getTimeAgoToNow(creationDate, DateTime.now());

  String getTimeAgoToNow(
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

  factory TweetModel.fromMap(Map<String, dynamic> data) {
    return TweetModel(
      id: data["id"],
      userId: data["userId"],
      text: data["text"],
      creationDate: DateTime.parse(data["creationDate"]),
      heartCount: data["heartCount"],
      commentCount: data["commentCount"],
      retweetCount: data["retweetCount"],
      userModel: UserModel.fromMapSingleTweet(data["user"]),
    );
  }
}
