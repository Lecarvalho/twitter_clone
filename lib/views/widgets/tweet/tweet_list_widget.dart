import 'package:flutter/material.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/views/widgets/divider_widget.dart';
import 'package:twitter_clone/views/widgets/tweet/tweet_simple_widget.dart';

class TweetListWidget extends StatelessWidget {
  final List<TweetModel> tweets;
  TweetListWidget({@required this.tweets});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      separatorBuilder: (_, __) => DividerWidget(),
      itemCount: tweets.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: TweetSimpleWidget(tweetModel: tweets[index]),
        );
      },
    );
  }
}
