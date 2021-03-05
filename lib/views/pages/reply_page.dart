import 'package:flutter/material.dart';
import 'package:twitter_clone/config/routes.dart';
import 'package:twitter_clone/controllers/comments_controller.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/di/di.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/views/widgets/appbar_widget.dart';
import 'package:twitter_clone/views/widgets/button/button_widget.dart';
import 'package:twitter_clone/views/widgets/tweet/tweet_reply_to_widget.dart';

class ReplyPage extends StatefulWidget {
  @override
  _ReplyPageState createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage> {
  ProfileController _profileController;
  CommentController _commentController;
  TweetModel _commentingTweet;

  final _textController = TextEditingController();
  bool get _hasText => _textController.text?.isNotEmpty ?? false;
  Function _onPressedReplyTweet;

  @override
  void didChangeDependencies() {
    _profileController = Di.instanceOf(context);
    _commentController = Di.instanceOf(context);
    _commentingTweet = ModalRoute.of(context).settings.arguments;

    _textController.addListener(() {
      if (_hasText && _onPressedReplyTweet == null) {
        setState(() {
          _onPressedReplyTweet = _onCommentTweet;
        });
      } else if (!_hasText) {
        setState(() {
          _onPressedReplyTweet = null;
        });
      }
    });

    super.didChangeDependencies();
  }

  void _onCommentTweet() async {
    await _commentController.commentTweet(
      tweetId: _commentingTweet.id,
      commentText: _textController.text,
      myProfileId: _profileController.myProfile.id,
    );

    Navigator.of(context).pushReplacementNamed(
      Routes.big_tweet,
      arguments: _commentingTweet.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        action: Padding(
          padding: const EdgeInsets.all(10),
          child: ButtonWidget(
            onPressed: _onPressedReplyTweet,
            text: "Reply",
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: TweetReplyToWidget(
          avatar: _profileController.myProfile.avatar,
          myProfileId: _profileController.myProfile.id,
          controller: _textController,
          replyingToNickname: _commentingTweet.profile.nickname,
        ),
      ),
    );
  }
}
