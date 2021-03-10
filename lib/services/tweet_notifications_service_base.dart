import 'package:twitter_clone/models/tweet_notification_model.dart';
import 'package:twitter_clone/services/service_base.dart';
import 'package:twitter_clone/services/service_provider_base.dart';

abstract class TweetNotificationsServiceBase extends ServiceBase  {
  TweetNotificationsServiceBase(ServiceProviderBase provider) : super(provider);

  Future<List<TweetNotificationModel>?> getMyTweetsNotifications(String myProfileId);
}