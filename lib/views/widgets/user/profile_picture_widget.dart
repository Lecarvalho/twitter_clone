import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/colors.dart';

class ProfilePictureWidget extends StatelessWidget {
  final String avatar;
  final String userId;
  final ProfilePicSize profilePicSize;
  final Function onTap;

  ProfilePictureWidget({
    @required this.avatar,
    @required this.userId,
    @required this.profilePicSize,
    this.onTap,
  });

  double _getImageSize() {
    double _imageSize;

    switch (profilePicSize) {
      case ProfilePicSize.small:
        _imageSize = 45;
        break;
      case ProfilePicSize.small2:
        _imageSize = 55;
        break;
      case ProfilePicSize.medium:
        _imageSize = 60;
        break;
      case ProfilePicSize.large:
        _imageSize = 95;
        break;
    }

    return _imageSize;
  }

  @override
  Widget build(BuildContext context) {
    double _imageSize = _getImageSize();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(avatar),
            fit: BoxFit.cover,
          ),
          border: Border.all(color: ProjectColors.white, width: 3),
        ),
        width: _imageSize,
        height: _imageSize,
      ),
    );
  }
}

enum ProfilePicSize { small, small2, medium, large }
