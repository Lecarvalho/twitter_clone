import 'package:flutter/material.dart';
import 'package:twitter_clone/config/routes.dart';
import 'package:twitter_clone/controllers/my_session_controller.dart';
import 'package:twitter_clone/controllers/tweet_notifications_controller.dart';
import 'package:twitter_clone/di/di.dart';
import 'package:twitter_clone/models/tweet_notification_model.dart';
import 'package:twitter_clone/views/widgets/divider_widget.dart';
import 'package:twitter_clone/views/widgets/tweet/tweet_notification_widget.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  TweetNotificationsController _tweetNotificationsController;
  MySessionController _mySessionController;

  @override
  void didChangeDependencies() {
    _tweetNotificationsController =
        Di.instanceOf<TweetNotificationsController>(context);
    _mySessionController = Di.instanceOf<MySessionController>(context);

    super.didChangeDependencies();
  }

  void _onPressNotification(BuildContext context, String tweetId) {
    Navigator.of(context).pushNamed(Routes.big_tweet, arguments: tweetId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TweetNotificationModel>>(
      future: _tweetNotificationsController.getMyTweetsNotifications(
        _mySessionController.mySession.profileId,
      ),
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
              child: GestureDetector(
                onTap: () => _onPressNotification(
                  context,
                  snapshot.data[index].tweetId,
                ),
                child: TweetNotificationWidget(
                  tweetNotification: snapshot.data[index],
                ),
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
