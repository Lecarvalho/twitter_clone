import 'package:flutter/material.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/controllers/tweet_controller.dart';
import 'package:twitter_clone/config/di.dart';
import 'package:twitter_clone/views/widgets/appbar_widget.dart';
import 'package:twitter_clone/views/widgets/button/button_actionbar_widget.dart';
import 'package:twitter_clone/views/widgets/tweet/tweet_create_new_widget.dart';

import '../screen_state.dart';

class NewTweetPage extends StatefulWidget {
  @override
  _NewTweetPageState createState() => _NewTweetPageState();
}

class _NewTweetPageState extends State<NewTweetPage> {
  late ProfileController _profileController;
  late TweetController _tweetController;
  Function()? _onPressedCreateTweet;

  final _textController = TextEditingController();

  @override
  void didChangeDependencies() {
    _profileController = Di.instanceOf(context);
    _tweetController = Di.instanceOf(context);

    _textController.addListener(() {
      if (_hasText && _onPressedCreateTweet == null) {
        _onPressedCreateTweet = _onCreateTweet;
        ScreenState.refreshView(this);
      } else if (!_hasText) {
        _onPressedCreateTweet = null;
        ScreenState.refreshView(this);
      }
    });

    super.didChangeDependencies();
  }

  void _onCreateTweet() async {
    if (_textController.text.isNotEmpty) {
      await _tweetController.createTweet(
        _textController.text,
        _profileController.myProfile,
      );

      Navigator.of(context).pop();
    }
  }

  bool get _hasText => _textController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        action: ButtonActionBarWidget(
          onPressed: _onPressedCreateTweet,
          text: "Tweet",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: TweetCreateNewWidget(
          avatar: _profileController.myProfile.avatar!,
          myProfileId: _profileController.myProfile.id,
          controller: _textController,
        ),
      ),
    );
  }
}
