import 'package:flutter/material.dart';
import 'package:twitter_clone/controllers/comments_controller.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/controllers/tweet_controller.dart';
import 'package:twitter_clone/config/di.dart';
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
  late TweetController _tweetController;
  late CommentController _commentController;
  late ProfileController _profileController;

  late TweetModel _tweet;
  late String _tweetId;
  bool _isPageReady = false;

  @override
  void didChangeDependencies() async {
    _tweetId = ModalRoute.of(context)!.settings.arguments!.toString();
    _tweetController = Di.instanceOf(context);
    _commentController = Di.instanceOf(context);
    _profileController = Di.instanceOf(context);

    await _tweetController.getTweet(_tweetId);
    await _commentController.getComments(_tweetId);

    _tweet = _tweetController.bigTweet!;

    setState(() {
      _isPageReady = true;
    });

    super.didChangeDependencies();
  }

  void _onPressHeart(TweetModel tweet) async {
    await _tweetController.toggleLikeTweet(
      tweet,
      _profileController.myProfile!.id,
    );

    setState(() {});
  }

  void _onPressRetweet(TweetModel tweet) {
    if (_tweet.canRetweet(_profileController.myProfile!.id)) {
      showModalBottomSheet(
        context: context,
        shape: RoundedBottomSheet(),
        builder: (_) => ConfirmRetweet(
          onConfirmRetweet: () async {
            await _tweetController.retweet(
              tweet,
              _profileController.myProfile!.id,
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
                    comments: _commentController.comments!,
                    replyingToNickname: _tweet.profile.nickname,
                  )
                ],
              ),
            ),
    );
  }
}
