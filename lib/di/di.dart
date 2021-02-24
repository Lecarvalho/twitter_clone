import 'package:provider/provider.dart';
import 'package:twitter_clone/controllers/auth_controller.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/controllers/tweet_controller.dart';
import 'package:twitter_clone/controllers/tweet_notifications_controller.dart';
import 'package:twitter_clone/services/mock/auth_service_mock.dart';
import 'package:twitter_clone/services/mock/profile_service_mock.dart';
import 'package:twitter_clone/services/mock/tweet_notifications_service_mock.dart';
import 'package:twitter_clone/services/mock/tweets_service_mock.dart';

class Di {
  Di._();

  static init<T>(child) {
    return MultiProvider(
      providers: [
        Provider<AuthController>(
          create: (_) => AuthController(service: AuthServiceMock()),
        ),
        Provider<TweetController>(
          create: (_) => TweetController(service: TweetsServiceMock()),
        ),
        Provider<ProfileController>(
          create: (_) => ProfileController(service: ProfileServiceMock()),
        ),
        Provider<TweetNotificationsController>(
          create: (_) => TweetNotificationsController(
            service: TweetNotificationsServiceMock(),
          ),
        ),
      ],
      child: child,
    );
  }
}
