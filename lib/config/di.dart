import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/controllers/reply_controller.dart';
import 'package:twitter_clone/controllers/controller_base.dart';
import 'package:twitter_clone/controllers/search_controller.dart';
import 'package:twitter_clone/controllers/user_controller.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/controllers/tweet_controller.dart';
import 'package:twitter_clone/controllers/tweet_notifications_controller.dart';
import 'package:twitter_clone/services/mock/reply_service_mock.dart';
import 'package:twitter_clone/services/mock/search_service_mock.dart';
import 'package:twitter_clone/services/mock/auth_service_mock.dart';
import 'package:twitter_clone/services/mock/profile_service_mock.dart';
import 'package:twitter_clone/services/mock/tweet_notifications_service_mock.dart';
import 'package:twitter_clone/services/mock/tweets_service_mock.dart';

class Di {
  Di._();

  static init<T>(child) {
    return MultiProvider(
      providers: [
        Provider<UserController>(
          create: (_) => UserController(service: AuthServiceMock()),
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
        Provider<ReplyController>(
          create: (_) => ReplyController(service: ReplyServiceMock()),
        ),
        Provider<SearchController>(
          create: (_) => SearchController(service: SearchServiceMock()),
        )
      ],
      child: child,
    );
  }

  static T instanceOf<T extends ControllerBase>(BuildContext context){
    return Provider.of<T>(context, listen: false);
  }
}
