import 'package:flutter/material.dart';

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
        _imageSize = 30;
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
    return ClipOval(
      child: Image.asset(
        photoUrl,
        height: _imageSize,
        width: _imageSize,
        fit: BoxFit.fill,
      ),
    );
  }
}

enum ProfilePicSize { small, medium, large }
