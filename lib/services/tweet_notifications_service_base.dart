import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/models/tweet_notification_model.dart';
import 'package:twitter_clone/services/service_base.dart';

abstract class TweetNotificationsServiceBase extends ServiceBase  {
  Future<List<TweetNotificationModel>> getMyTweetsNotifications(String myUserId);
}