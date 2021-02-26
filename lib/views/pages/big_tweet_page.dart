import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/controllers/comments_controller.dart';
import 'package:twitter_clone/controllers/tweet_controller.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/views/resources/styles.dart';
import 'package:twitter_clone/views/widgets/appbar_widget.dart';
import 'package:twitter_clone/views/widgets/divider_widget.dart';
import 'package:twitter_clone/views/widgets/textbox/loading_page_widget.dart';
import 'package:twitter_clone/views/widgets/tweet/comment_list_widget.dart';
import 'package:twitter_clone/views/widgets/tweet/tweet_actions_widget.dart';
import 'package:twitter_clone/views/widgets/tweet/tweet_big_single_widget.dart';

class BigTweetPage extends StatefulWidget {
  @override
  _BigTweetPageState createState() => _BigTweetPageState();
}

class _BigTweetPageState extends State<BigTweetPage> {
  TweetController _tweetController;
  CommentController _commentController;

  TweetModel _tweetModel;
  String _tweetId;
  bool _isPageReady = false;

  @override
  void didChangeDependencies() async {
    _tweetId = ModalRoute.of(context).settings.arguments;
    _tweetController = Provider.of<TweetController>(context);
    _commentController = Provider.of<CommentController>(context);

    await _tweetController.getTweet(_tweetId);
    await _commentController.getComments(_tweetId);

    _tweetModel = _tweetController.bigTweet;

    setState(() {
      _isPageReady = true;
    });

    super.didChangeDependencies();
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
                  TweetBigSingleWidget(tweetModel: _tweetModel),
                  DividerWidget(),
                  TweetActionsWidget(
                    tweetModel: _tweetModel,
                  ),
                  DividerWidget(),
                  CommentListWidget(
                    comments: _commentController.comments,
                    replyingToNickname: _tweetModel.userModel.nickname,
                  )
                ],
              ),
            ),
    );
  }
}
