import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/controllers/user_session_controller.dart';
import 'package:twitter_clone/controllers/tweet_notifications_controller.dart';
import 'package:twitter_clone/models/tweet_notification_model.dart';
import 'package:twitter_clone/views/widgets/divider_widget.dart';
import 'package:twitter_clone/views/widgets/tweet/tweet_notification_widget.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  TweetNotificationsController _tweetNotificationsController;
  UserSessionController _userSessionController;

  @override
  void didChangeDependencies() {
    _tweetNotificationsController =
        Provider.of<TweetNotificationsController>(context);
    _userSessionController = Provider.of<UserSessionController>(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TweetNotificationModel>>(
      future: _tweetNotificationsController
          .getMyTweetsNotifications(_userSessionController.authUser.userId),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.separated(
            separatorBuilder: (__, _) => DividerWidget(),
            itemBuilder: (__, index) => Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
                bottom: 10,
              ),
              child: TweetNotificationWidget(
                tweetNotification: snapshot.data[index],
              ),
            ),
            itemCount: snapshot.data.length,
          );
        }

        return Container();
      },
    );
  }
}
