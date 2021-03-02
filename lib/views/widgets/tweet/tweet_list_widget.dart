import 'package:flutter/material.dart';
import 'package:twitter_clone/config/routes.dart';
import 'package:twitter_clone/controllers/my_session_controller.dart';
import 'package:twitter_clone/controllers/tweet_controller.dart';
import 'package:twitter_clone/di/di.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/views/resources/rounded_bottom_sheet.dart';
import 'package:twitter_clone/views/widgets/divider_widget.dart';
import 'package:twitter_clone/views/widgets/tweet/tweet_simple_widget.dart';

import 'confirm_retweet.dart';

class TweetListWidget extends StatefulWidget {
  final List<TweetModel> tweets;
  TweetListWidget({@required this.tweets});

  @override
  _TweetListWidgetState createState() => _TweetListWidgetState();
}

class _TweetListWidgetState extends State<TweetListWidget> {
  TweetController _tweetController;
  MySessionController _mySessionController;

  @override
  void didChangeDependencies() {
    _tweetController = Di.instanceOf<TweetController>(context);
    _mySessionController = Di.instanceOf<MySessionController>(context);

    super.didChangeDependencies();
  }

  void _onPressHeart(TweetModel tweet) async {
    await _tweetController.toggleHeartTweet(
      tweet,
      _mySessionController.mySession.profileId,
    );
    setState(() {});
  }

  void _onPressRetweet(TweetModel tweet) async {
    if (tweet.canRetweet(_mySessionController.mySession.profileId)) {
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
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      separatorBuilder: (_, __) => DividerWidget(),
      itemCount: widget.tweets.length,
      itemBuilder: (_, index) {
        var tweet = widget.tweets[index];

        return Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(
              Routes.big_tweet,
              arguments: tweet.id,
            ),
            child: TweetSimpleWidget(
              tweet: tweet,
              onHeart: () => _onPressHeart(tweet),
              onRetweet: () => _onPressRetweet(tweet),
            ),
          ),
        );
      },
    );
  }
}
