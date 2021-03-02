import 'package:flutter/material.dart';
import 'package:twitter_clone/controllers/comments_controller.dart';
import 'package:twitter_clone/controllers/my_session_controller.dart';
import 'package:twitter_clone/controllers/tweet_controller.dart';
import 'package:twitter_clone/di/di.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/views/resources/rounded_bottom_sheet.dart';
import 'package:twitter_clone/views/resources/styles.dart';
import 'package:twitter_clone/views/widgets/appbar_widget.dart';
import 'package:twitter_clone/views/widgets/divider_widget.dart';
import 'package:twitter_clone/views/widgets/textbox/loading_page_widget.dart';
import 'package:twitter_clone/views/widgets/tweet/comment_list_widget.dart';
import 'package:twitter_clone/views/widgets/tweet/confirm_retweet.dart';
import 'package:twitter_clone/views/widgets/tweet/tweet_actions/tweet_actions_widget.dart';
import 'package:twitter_clone/views/widgets/tweet/tweet_big_single_widget.dart';

class BigTweetPage extends StatefulWidget {
  @override
  _BigTweetPageState createState() => _BigTweetPageState();
}

class _BigTweetPageState extends State<BigTweetPage> {
  TweetController _tweetController;
  CommentController _commentController;
  MySessionController _mySessionController;

  TweetModel _tweet;
  String _tweetId;
  bool _isPageReady = false;

  @override
  void didChangeDependencies() async {
    _tweetId = ModalRoute.of(context).settings.arguments;
    _tweetController = Di.instanceOf<TweetController>(context);
    _commentController = Di.instanceOf<CommentController>(context);
    _mySessionController = Di.instanceOf<MySessionController>(context);

    await _tweetController.getTweet(_tweetId);
    await _commentController.getComments(_tweetId);

    _tweet = _tweetController.bigTweet;

    setState(() {
      _isPageReady = true;
    });

    super.didChangeDependencies();
  }

  void _onPressHeart(TweetModel tweet) async {
    await _tweetController.toggleHeartTweet(
      tweet,
      _mySessionController.mySession.profileId,
    );

    setState(() {});
  }

  void _onPressRetweet(TweetModel tweet) {
    if (_tweet.canRetweet(_mySessionController.mySession.profileId)) {
      showModalBottomSheet(
        context: context,
        shape: RoundedBottomSheet(),
        builder: (_) => ConfirmRetweet(
          onConfirmRetweet: () async {
            await _tweetController.retweet(
              tweet,
              _mySessionController.mySession.profileId,
            );
            setState(() {});
            Navigator.of(context).pop();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: Text("Tweet", style: Styles.h6)),
      body: !_isPageReady
          ? LoadingPageWidget()
          : SingleChildScrollView(
              child: Column(
                children: [
                  TweetBigSingleWidget(tweet: _tweet),
                  DividerWidget(),
                  TweetActionsWidget(
                    tweet: _tweet,
                    onHeart: () => _onPressHeart(_tweet),
                    onRetweet: () => _onPressRetweet(_tweet),
                  ),
                  DividerWidget(),
                  CommentListWidget(
                    comments: _commentController.comments,
                    replyingToNickname: _tweet.profile.nickname,
                  )
                ],
              ),
            ),
    );
  }
}
