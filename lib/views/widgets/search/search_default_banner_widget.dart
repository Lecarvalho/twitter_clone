import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/resources/styles.dart';

class SearchDefaultBannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ProjectColors.white,
      padding: EdgeInsets.only(left: 30, right: 30),
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Find people to follow",
            style: Styles.h6,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            "It seems like there’s a lot to show you right now, just find someone on the search bar",
            style: Styles.body2Gray,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
