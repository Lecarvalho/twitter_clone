import 'package:flutter/material.dart';
import 'package:twitter_clone/views/routes.dart';
import 'package:twitter_clone/controllers/reply_controller.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/config/di.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/views/widgets/appbar_widget.dart';
import 'package:twitter_clone/views/widgets/button/button_actionbar_widget.dart';
import 'package:twitter_clone/views/widgets/tweet/write_reply_widget.dart';

class ReplyPage extends StatefulWidget {
  @override
  _ReplyPageState createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage> {
  late ProfileController _profileController;
  late ReplyController _replyController;
  late TweetModel _replyingTweet;

  final _textController = TextEditingController();
  bool get _hasText => _textController.text.isNotEmpty;
  Function()? _onPressedReplyTweet;

  @override
  void didChangeDependencies() {
    _profileController = Di.instanceOf(context);
    _replyController = Di.instanceOf(context);
    _replyingTweet = ModalRoute.of(context)!.settings.arguments! as TweetModel;

    _textController.addListener(() {
      if (_hasText && _onPressedReplyTweet == null) {
        setState(() {
          _onPressedReplyTweet = _onReplyTweet;
        });
      } else if (!_hasText) {
        setState(() {
          _onPressedReplyTweet = null;
        });
      }
    });

    super.didChangeDependencies();
  }

  void _onReplyTweet() async {
    await _replyController.replyTweet(
      replyingToTweetId: _replyingTweet.id,
      text: _textController.text,
      myProfileId: _profileController.myProfile.id,
      replyingToProfileId: _replyingTweet.profileId
    );

    Navigator.of(context).pushReplacementNamed(
      Routes.opened_tweet,
      arguments: _replyingTweet.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        action: ButtonActionBarWidget(
          onPressed: _onPressedReplyTweet,
          text: "Reply",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: WriteReplyWidget(
          avatar: _profileController.myProfile.avatar!,
          myProfileId: _profileController.myProfile.id,
          controller: _textController,
          replyingToNickname: _replyingTweet.profile.nicknameWithAt,
        ),
      ),
    );
  }
}
