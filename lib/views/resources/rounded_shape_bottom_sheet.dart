import 'package:flutter/material.dart';

class RoundedShapeBottomSheet extends RoundedRectangleBorder {
  @override
  BorderRadiusGeometry get borderRadius => BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
      );
}
