import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/config/routes.dart';
import 'package:twitter_clone/controllers/user_session_controller.dart';
import 'package:twitter_clone/controllers/tweet_controller.dart';
import 'package:twitter_clone/views/widgets/appbar_widget.dart';
import 'package:twitter_clone/views/widgets/button/button_widget.dart';
import 'package:twitter_clone/views/widgets/tweet/tweet_create_new_widget.dart';

class NewTweetPage extends StatefulWidget {
  @override
  _NewTweetPageState createState() => _NewTweetPageState();
}

class _NewTweetPageState extends State<NewTweetPage> {
  UserSessionController _userSessionController;
  TweetController _tweetController;
  final _textController = TextEditingController();

  @override
  void didChangeDependencies() {
    _userSessionController = Provider.of<UserSessionController>(context);
    _tweetController = Provider.of<TweetController>(context);
    super.didChangeDependencies();
  }

  void _onCreateTweet() async {
    await _tweetController.createTweet(
      _textController.text,
      _userSessionController.authUser.userId,
    );

    Navigator.of(context).pushReplacementNamed(Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        action: Padding(
          padding: const EdgeInsets.all(10),
          child: ButtonWidget(
            onPressed: _onCreateTweet,
            text: "Tweet",
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: TweetCreateNewWidget(
          avatar: _userSessionController.authUser.avatar,
          myUserId: _userSessionController.authUser.userId,
          controller: _textController,
        ),
      ),
    );
  }
}
