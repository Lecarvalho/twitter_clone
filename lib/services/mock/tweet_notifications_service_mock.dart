import 'package:twitter_clone/models/tweet_notification_model.dart';

import '../tweet_notifications_service_base.dart';
import 'mock_tools.dart';
import 'service_provider_mock.dart';

class TweetNotificationsServiceMock extends TweetNotificationsServiceBase {
  TweetNotificationsServiceMock(ServiceProviderMock provider) : super(provider);

  @override
  Future<List<TweetNotificationModel>?> getMyTweetsNotifications(String myProfileId) async {

    await MockTools.simulateQuickRequestDelay();

    return MockTools.jsonToModelList<TweetNotificationModel>(
      "assets/json/tweet_notifications.json",
      (data) => TweetNotificationModel.fromMap(data),
    );
  }
}
