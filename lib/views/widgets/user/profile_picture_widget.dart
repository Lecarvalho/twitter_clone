import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/colors.dart';

class ProfilePictureWidget extends StatelessWidget {
  final String photoUrl;
  final ProfilePicSize profilePicSize;

  ProfilePictureWidget({
    @required this.photoUrl,
    @required this.profilePicSize,
  });

  double _getImageSize() {
    double _imageSize;

    switch (profilePicSize) {
      case ProfilePicSize.small:
        _imageSize = 40;
        break;
      case ProfilePicSize.small2:
        _imageSize = 55;
        break;
      case ProfilePicSize.medium:
        _imageSize = 60;
        break;
      case ProfilePicSize.large:
        _imageSize = 90;
        break;
    }

    return _imageSize;
  }

  @override
  Widget build(BuildContext context) {
    double _imageSize = _getImageSize();
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(photoUrl),
          fit: BoxFit.cover,
        ),
        border: Border.all(color: ProjectColors.white),
      ),
      width: _imageSize,
      height: _imageSize,
    );
  }
}

enum ProfilePicSize { small, small2, medium, large }
