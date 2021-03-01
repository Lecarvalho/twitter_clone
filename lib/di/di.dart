import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/controllers/comments_controller.dart';
import 'package:twitter_clone/controllers/controller_base.dart';
import 'package:twitter_clone/controllers/search_controller.dart';
import 'package:twitter_clone/controllers/my_session_controller.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/controllers/tweet_controller.dart';
import 'package:twitter_clone/controllers/tweet_notifications_controller.dart';
import 'package:twitter_clone/services/mock/comment_service_mock.dart';
import 'package:twitter_clone/services/mock/search_service_mock.dart';
import 'package:twitter_clone/services/mock/my_session_service_mock.dart';
import 'package:twitter_clone/services/mock/profile_service_mock.dart';
import 'package:twitter_clone/services/mock/tweet_notifications_service_mock.dart';
import 'package:twitter_clone/services/mock/tweets_service_mock.dart';

class Di {
  Di._();

  static init<T>(child) {
    return MultiProvider(
      providers: [
        Provider<MySessionController>(
          create: (_) => MySessionController(service: MySessionServiceMock()),
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
        Provider<CommentController>(
          create: (_) => CommentController(service: CommentServiceMock()),
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
