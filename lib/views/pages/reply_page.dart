import 'package:flutter/material.dart';
import 'package:twitter_clone/views/routes.dart';
import 'package:twitter_clone/controllers/comments_controller.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/config/di.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/views/widgets/appbar_widget.dart';
import 'package:twitter_clone/views/widgets/button/button_actionbar_widget.dart';
import 'package:twitter_clone/views/widgets/tweet/tweet_reply_to_widget.dart';

class ReplyPage extends StatefulWidget {
  @override
  _ReplyPageState createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage> {
  late ProfileController _profileController;
  late CommentController _commentController;
  late TweetModel _commentingTweet;

  final _textController = TextEditingController();
  bool get _hasText => _textController.text.isNotEmpty;
  Function()? _onPressedReplyTweet;

  @override
  void didChangeDependencies() {
    _profileController = Di.instanceOf(context);
    _commentController = Di.instanceOf(context);
    _commentingTweet = ModalRoute.of(context)!.settings.arguments! as TweetModel;

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
      myProfile: _profileController.myProfile!,
      replyingToProfileId: _commentingTweet.profileId
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
        action: ButtonActionBarWidget(
          onPressed: _onPressedReplyTweet,
          text: "Reply",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: TweetReplyToWidget(
          avatar: _profileController.myProfile!.avatar,
          myProfileId: _profileController.myProfile!.id,
          controller: _textController,
          replyingToNickname: _commentingTweet.profile.nickname,
        ),
      ),
    );
  }
}
