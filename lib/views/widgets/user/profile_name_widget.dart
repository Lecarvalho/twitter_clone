import 'package:flutter/material.dart';

class ProfileNameWidget extends StatelessWidget {
  final String profileName;
  final TextStyle textStyle;

  ProfileNameWidget({
    required this.profileName,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      profileName,
      style: textStyle,
    );
  }
}
