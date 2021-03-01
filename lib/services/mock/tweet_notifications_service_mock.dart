import 'package:twitter_clone/models/tweet_notification_model.dart';

import '../tweet_notifications_service_base.dart';
import 'json_tools.dart';

class TweetNotificationsServiceMock implements TweetNotificationsServiceBase {
  @override
  Future<List<TweetNotificationModel>> getMyTweetsNotifications(String myProfileId) {
    return JsonTools.jsonToModelList<TweetNotificationModel>(
      "assets/json/tweet_notifications.json",
      (data) => TweetNotificationModel.fromMap(data),
    );
  }
}
