import 'package:flutter/material.dart';

import '../project_typography.dart';

class ProfileNickNameWidget extends StatelessWidget {
  final String profileNickName;
  ProfileNickNameWidget({@required this.profileNickName});

  @override
  Widget build(BuildContext context) {
    return Text(profileNickName, style: ProjectTypography.subtitle1Gray);
  }
}
