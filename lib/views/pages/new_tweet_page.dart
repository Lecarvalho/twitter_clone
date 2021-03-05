import 'package:flutter/material.dart';
import 'package:twitter_clone/config/routes.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/controllers/tweet_controller.dart';
import 'package:twitter_clone/di/di.dart';
import 'package:twitter_clone/views/widgets/appbar_widget.dart';
import 'package:twitter_clone/views/widgets/button/button_widget.dart';
import 'package:twitter_clone/views/widgets/tweet/tweet_create_new_widget.dart';

class NewTweetPage extends StatefulWidget {
  @override
  _NewTweetPageState createState() => _NewTweetPageState();
}

class _NewTweetPageState extends State<NewTweetPage> {
  ProfileController _profileController;
  TweetController _tweetController;
  final _textController = TextEditingController();

  @override
  void didChangeDependencies() {
    _profileController = Di.instanceOf(context);
    _tweetController = Di.instanceOf(context);

    _textController.addListener(() {
      if (_hasText && _onPressedCreateTweet == null) {
        setState(() {
          _onPressedCreateTweet = _onCreateTweet;
        });
      } else if (!_hasText) {
        setState(() {
          _onPressedCreateTweet = null;
        });
      }
    });

    super.didChangeDependencies();
  }

  void _onCreateTweet() async {
    if (_textController.text?.isNotEmpty ?? true) {
      await _tweetController.createTweet(
        _textController.text,
        _profileController.myProfile.id,
      );

      Navigator.of(context).pushReplacementNamed(Routes.home);
    }
  }

  bool get _hasText => _textController.text?.isNotEmpty ?? false;

  Function _onPressedCreateTweet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        action: Padding(
          padding: const EdgeInsets.all(10),
          child: ButtonWidget(
            onPressed: _onPressedCreateTweet,
            text: "Tweet",
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: TweetCreateNewWidget(
          avatar: _profileController.myProfile.avatar,
          myProfileId: _profileController.myProfile.id,
          controller: _textController,
        ),
      ),
    );
  }
}
