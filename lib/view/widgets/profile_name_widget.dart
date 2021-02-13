import 'package:flutter/material.dart';
import 'package:twitter_clone/view/project_typography.dart';

class ProfileNameWidget extends StatelessWidget {
  final String profileName;
  final ProfileNameSize profileNameSize;

  ProfileNameWidget({
    @required this.profileName,
    @required this.profileNameSize,
  });

  TextStyle _getTextStyle() {
    TextStyle _textStyle;

    switch (profileNameSize) {
      case ProfileNameSize.small:
        _textStyle = ProjectTypography.subtitle1;
        break;
      case ProfileNameSize.medium:
        _textStyle = ProjectTypography.h6;
        break;
      case ProfileNameSize.large:
        _textStyle = ProjectTypography.h5;
        break;
    }

    return _textStyle;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      profileName,
      style: _getTextStyle(),
    );
  }
}

enum ProfileNameSize { small, medium, large }
