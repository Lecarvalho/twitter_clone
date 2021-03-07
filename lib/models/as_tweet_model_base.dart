import 'package:intl/intl.dart';

import 'model_base.dart';
import 'profile_model.dart';

abstract class AsTweetModelBase extends ModelBase {
  String id;
  String text;
  DateTime createdAt;
  String profileId;
  ProfileModel profile;

  AsTweetModelBase({
    required this.id,
    required this.profileId,
    required this.text,
    required this.createdAt,
    required this.profile,
  });

  String get createdAtLong => DateFormat.Hm().add_yMd().format(createdAt);
  String get creationTimeAgo => getTimeAgoToNow(createdAt, DateTime.now());

  static String getTimeAgoToNow(DateTime createdAt, DateTime now) {
    var difference = createdAt.difference(now);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return (difference.inSeconds * -1).toString() + "s";
        }
        return (difference.inMinutes * -1).toString() + "m";
      }
      return (difference.inHours * -1).toString() + "h";
    }
    return (difference.inDays * -1).toString() + "d";
  }
}
