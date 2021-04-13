import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/controllers/feed_controller.dart';
import 'package:twitter_clone/controllers/reply_controller.dart';
import 'package:twitter_clone/controllers/controller_base.dart';
import 'package:twitter_clone/controllers/search_controller.dart';
import 'package:twitter_clone/controllers/auth_controller.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/controllers/tweet_controller.dart';
import 'package:twitter_clone/controllers/tweet_notifications_controller.dart';
import 'package:twitter_clone/services/feed_service.dart';
import 'package:twitter_clone/services/profile_service.dart';
import 'package:twitter_clone/services/providers/auth_provider.dart';
import 'package:twitter_clone/services/mock/service_provider_mock.dart';
import 'package:twitter_clone/services/mock/tweet_notifications_service_mock.dart';
import 'package:twitter_clone/services/providers/core_provider.dart';
import 'package:twitter_clone/services/providers/database_provider.dart';
import 'package:twitter_clone/services/providers/database_storage_provider.dart';
import 'package:twitter_clone/services/providers/storage_provider.dart';
import 'package:twitter_clone/services/reply_service.dart';
import 'package:twitter_clone/services/search_service.dart';
import 'package:twitter_clone/services/tweet_service.dart';
import 'package:twitter_clone/services/auth_service.dart';

class Di {
  Di._();


  static init<T>(child) async {
    final mockProvider = ServiceProviderMock();
    final authProvider = AuthProvider();
    final databaseProvider = DatabaseProvider();
    final storageProvider = StorageProvider();

    final databaseStorageProvider = DatabaseStorageProvider(
      databaseProvider,
      storageProvider,
    );

    await CoreProvider().init();
    await authProvider.init();
    await databaseProvider.init();
    await storageProvider.init();

    return MultiProvider(
      providers: [
        Provider<TweetController>(
          create: (_) => TweetController(
            service: TweetService(databaseProvider),
          ),
        ),
        Provider<ProfileController>(
          create: (_) => ProfileController(
            service: ProfileService(databaseStorageProvider),
          ),
        ),
        Provider<TweetNotificationsController>(
          create: (_) => TweetNotificationsController(
            service: TweetNotificationsServiceMock(mockProvider),
          ),
        ),
        Provider<ReplyController>(
          create: (_) => ReplyController(
            service: ReplyService(databaseProvider),
          ),
        ),
        Provider<SearchController>(
          create: (_) => SearchController(
            service: SearchService(databaseProvider),
          ),
        ),
        Provider<AuthController>(
          create: (_) => AuthController(
            service: AuthService(authProvider),
            profileService: ProfileService(databaseStorageProvider),
          ),
        ),
        Provider<FeedController>(
          create: (_) => FeedController(
            service: FeedService(databaseProvider),
          ),
        ),
      ],
      child: child,
    );
  }

  static T instanceOf<T extends ControllerBase>(BuildContext context) {
    return Provider.of<T>(context, listen: false);
  }
}
