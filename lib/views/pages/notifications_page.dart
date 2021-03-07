import 'package:flutter/material.dart';
import 'package:twitter_clone/views/routes.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/controllers/tweet_notifications_controller.dart';
import 'package:twitter_clone/config/di.dart';
import 'package:twitter_clone/models/tweet_notification_model.dart';
import 'package:twitter_clone/views/widgets/divider_widget.dart';
import 'package:twitter_clone/views/widgets/tweet/tweet_notification_widget.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late TweetNotificationsController _tweetNotificationsController;
  late ProfileController _profileController;

  @override
  void didChangeDependencies() {
    _tweetNotificationsController = Di.instanceOf(context);
    _profileController = Di.instanceOf(context);

    super.didChangeDependencies();
  }

  void _onPressNotification(BuildContext context, String tweetId) {
    Navigator.of(context).pushNamed(Routes.opened_tweet, arguments: tweetId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TweetNotificationModel>>(
      future: _tweetNotificationsController.getMyTweetsNotifications(
        _profileController.myProfile!.id,
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
                  snapshot.data![index].tweetId,
                ),
                child: TweetNotificationWidget(
                  tweetNotification: snapshot.data![index],
                ),
              ),
            ),
            itemCount: snapshot.data!.length,
          );
        }

        return Container();
      },
    );
  }
}
