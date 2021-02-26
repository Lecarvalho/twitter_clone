import 'package:intl/intl.dart';

import 'model_base.dart';
import 'user_model.dart';

abstract class AsTweetModelBase extends ModelBase {
  String id;
  String text;
  DateTime creationDate;
  String userId;
  UserModel userModel;

  AsTweetModelBase({
    this.id,
    this.userId,
    this.text,
    this.creationDate,
    this.userModel,
  });

  String get creationDateLong => DateFormat.Hm().add_yMd().format(creationDate);
  String get creationTimeAgo => getTimeAgoToNow(creationDate, DateTime.now());

  String getTimeAgoToNow(DateTime creationDate, DateTime now) {
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
