import 'package:flutter/material.dart';
import 'package:twitter_clone/view/resources/styles.dart';

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
        _textStyle = Styles.subtitle1;
        break;
      case ProfileNameSize.medium:
        _textStyle = Styles.h6;
        break;
      case ProfileNameSize.large:
        _textStyle = Styles.h5;
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
