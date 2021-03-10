import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/controllers/reply_controller.dart';
import 'package:twitter_clone/controllers/controller_base.dart';
import 'package:twitter_clone/controllers/search_controller.dart';
import 'package:twitter_clone/controllers/user_controller.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/controllers/tweet_controller.dart';
import 'package:twitter_clone/controllers/tweet_notifications_controller.dart';
import 'package:twitter_clone/services/auth_provider.dart';
import 'package:twitter_clone/services/mock/profile_service_mock.dart';
import 'package:twitter_clone/services/mock/reply_service_mock.dart';
import 'package:twitter_clone/services/mock/search_service_mock.dart';
import 'package:twitter_clone/services/mock/service_provider_mock.dart';
import 'package:twitter_clone/services/mock/tweet_notifications_service_mock.dart';
import 'package:twitter_clone/services/mock/tweets_service_mock.dart';
import 'package:twitter_clone/services/database_provider.dart';
import 'package:twitter_clone/services/user_service.dart';

class Di {
  Di._();

  static init<T>(child) {

    final mockProvider = ServiceProviderMock();
    // final databaseProvider = DatabaseProvider();
    final authProvider = AuthProvider();
    
    return MultiProvider(
      providers: [
        Provider<TweetController>(
          create: (_) => TweetController(service: TweetsServiceMock(mockProvider)),
        ),
        Provider<ProfileController>(
          create: (_) => ProfileController(service: ProfileServiceMock(mockProvider)),
        ),
        Provider<TweetNotificationsController>(
          create: (_) => TweetNotificationsController(
            service: TweetNotificationsServiceMock(mockProvider),
          ),
        ),
        Provider<ReplyController>(
          create: (_) => ReplyController(service: ReplyServiceMock(mockProvider)),
        ),
        Provider<SearchController>(
          create: (_) => SearchController(service: SearchServiceMock(mockProvider)),
        ),
        Provider<UserController>(
          create: (_) => UserController(
            service: UserService(authProvider),
            profileService: ProfileServiceMock(mockProvider),
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
