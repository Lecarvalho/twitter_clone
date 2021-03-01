import 'package:flutter/material.dart';
import 'package:twitter_clone/models/comment_model.dart';

import '../divider_widget.dart';
import 'tweet_comment_widget.dart';

class CommentListWidget extends StatelessWidget {
  final List<CommentModel> comments;
  final String replyingToNickname;

  CommentListWidget({
    @required this.comments,
    @required this.replyingToNickname,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (_, index) => Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TweetCommentWidget(
          comment: comments[index],
          replyingToNickname: replyingToNickname,
        ),
      ),
      separatorBuilder: (_, __) => DividerWidget(),
      itemCount: comments.length,
    );
  }
}
