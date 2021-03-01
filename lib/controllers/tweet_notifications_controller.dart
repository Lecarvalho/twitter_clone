import 'package:flutter/foundation.dart';
import 'package:twitter_clone/controllers/controller_base.dart';
import 'package:twitter_clone/models/tweet_notification_model.dart';
import 'package:twitter_clone/services/tweet_notifications_service_base.dart';

class TweetNotificationsController
    extends ControllerBase<TweetNotificationsServiceBase> {
  TweetNotificationsController({@required service}) : super(service: service);

  Future<List<TweetNotificationModel>> getMyTweetsNotifications(
      String myProfileId) async {
    try {
      return await service.getMyTweetsNotifications(myProfileId);
    } catch (e) {
      print("Error on getMyTweetsNotifications: " + e);
    }

    return null;
  }
}
