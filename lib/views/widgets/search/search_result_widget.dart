import 'package:flutter/material.dart';
import 'package:twitter_clone/models/profile_model.dart';
import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/widgets/user/profile_picture_name_nick_horizontal_widget.dart';

class SearchResultWidget extends StatelessWidget {
  final ProfileModel profile;
  SearchResultWidget({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ProjectColors.white,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: ProfilePictureNameNickHorizontalWidget(profile: profile),
      ),
    );
  }
}
