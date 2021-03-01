import 'package:flutter/material.dart';
import 'package:twitter_clone/config/routes.dart';
import 'package:twitter_clone/controllers/comments_controller.dart';
import 'package:twitter_clone/controllers/my_session_controller.dart';
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
  MySessionController _mySessionController;
  CommentController _commentController;
  TweetModel _commentingTweet;

  final _textController = TextEditingController();

  @override
  void didChangeDependencies() {
    _mySessionController = Di.instanceOf<MySessionController>(context);
    _commentController = Di.instanceOf<CommentController>(context);
    _commentingTweet = ModalRoute.of(context).settings.arguments;

    super.didChangeDependencies();
  }

  void _onCommentTweet() async {
    await _commentController.commentTweet(
      tweetId: _commentingTweet.id,
      commentText: _textController.text,
      myProfileId: _mySessionController.mySession.myProfile.id,
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
            onPressed: _onCommentTweet,
            text: "Reply",
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: TweetReplyToWidget(
          avatar: _mySessionController.mySession.myProfile.avatar,
          myProfileId: _mySessionController.mySession.myProfile.id,
          controller: _textController,
          replyingToNickname: _commentingTweet.profile.nickname,
        ),
      ),
    );
  }
}
