import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/controllers/reply_controller.dart';
import 'package:twitter_clone/controllers/controller_base.dart';
import 'package:twitter_clone/controllers/search_controller.dart';
import 'package:twitter_clone/controllers/user_controller.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/controllers/tweet_controller.dart';
import 'package:twitter_clone/controllers/tweet_notifications_controller.dart';
import 'package:twitter_clone/services/mock/profile_service_mock.dart';
import 'package:twitter_clone/services/mock/reply_service_mock.dart';
import 'package:twitter_clone/services/mock/search_service_mock.dart';
import 'package:twitter_clone/services/mock/service_provider_mock.dart';
import 'package:twitter_clone/services/mock/tweet_notifications_service_mock.dart';
import 'package:twitter_clone/services/mock/tweets_service_mock.dart';
import 'package:twitter_clone/services/service_provider.dart';
import 'package:twitter_clone/services/user_service.dart';

class Di {
  Di._();

  static init<T>(child) {

    final providerMock = ServiceProviderMock();
    final providerFirebase = ServiceProvider();
    
    return MultiProvider(
      providers: [
        Provider<TweetController>(
          create: (_) => TweetController(service: TweetsServiceMock(providerMock)),
        ),
        Provider<ProfileController>(
          create: (_) => ProfileController(service: ProfileServiceMock(providerMock)),
        ),
        Provider<TweetNotificationsController>(
          create: (_) => TweetNotificationsController(
            service: TweetNotificationsServiceMock(providerMock),
          ),
        ),
        Provider<ReplyController>(
          create: (_) => ReplyController(service: ReplyServiceMock(providerMock)),
        ),
        Provider<SearchController>(
          create: (_) => SearchController(service: SearchServiceMock(providerMock)),
        ),
        Provider<UserController>(
          create: (_) => UserController(
            service: UserService(providerFirebase),
            profileService: ProfileServiceMock(providerMock),
          ),
        )
      ],
      child: child,
    );
  }

  static T instanceOf<T extends ControllerBase>(BuildContext context) {
    return Provider.of<T>(context, listen: false);
  }
}
