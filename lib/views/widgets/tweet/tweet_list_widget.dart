import 'package:flutter/material.dart';
import 'package:twitter_clone/views/routes.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/controllers/tweet_controller.dart';
import 'package:twitter_clone/config/di.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/views/resources/rounded_bottom_sheet.dart';

import '../divider_widget.dart';
import 'confirm_retweet.dart';
import 'tweet_line/single_tweet_widget.dart';

class TweetListWidget extends StatefulWidget {
  final List<TweetModel>? tweets;
  final Future<void> Function() onDragRefresh;
  TweetListWidget({required this.tweets, required this.onDragRefresh});

  @override
  _TweetListWidgetState createState() => _TweetListWidgetState();
}

class _TweetListWidgetState extends State<TweetListWidget> {
  late TweetController _tweetController;

  late ProfileController _profileController;

  @override
  void didChangeDependencies() {
    _tweetController = Di.instanceOf(context);
    _profileController = Di.instanceOf(context);

    super.didChangeDependencies();
  }

  void _onPressLike(TweetModel tweet) async {
    await _tweetController.toggleLikeTweet(
      tweet,
      _profileController.myProfile.id,
      _profileController.myProfile.name,
    );
    setState(() {});
  }

  void _onPressRetweet(TweetModel tweet) async {
    if (tweet.canRetweet(_profileController.myProfile.id)) {
      showModalBottomSheet(
        context: context,
        shape: RoundedBottomSheet(),
        builder: (_) => ConfirmRetweet(
          onConfirmRetweet: () async {
            await _tweetController.retweet(
              tweet,
              _profileController.myProfile.id,
              _profileController.myProfile.name,
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
    if (widget.tweets == null) return Container();
    return RefreshIndicator(
      onRefresh: widget.onDragRefresh,
      child: ListView.separated(
        physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        primary: false,
        separatorBuilder: (_, __) => DividerWidget(),
        itemCount: widget.tweets!.length,
        itemBuilder: (_, index) {
          var tweet = widget.tweets![index];

          return Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                Routes.opened_tweet,
                arguments: tweet.id,
              ),
              child: SingleTweetWidget(
                myProfileId: _profileController.myProfile.id,
                tweet: tweet,
                onLike: () => _onPressLike(tweet),
                onRetweet: () => _onPressRetweet(tweet),
              ),
            ),
          );
        },
      ),
    );
  }
}
