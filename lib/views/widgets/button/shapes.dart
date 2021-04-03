import 'package:flutter/widgets.dart';
import 'package:twitter_clone/views/resources/colors.dart';

class Shapes {

  Shapes._();

  static RoundedRectangleBorder rounded(){
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(20));
  }

  static RoundedRectangleBorder roundedBordered(){
    return rounded().copyWith(side: BorderSide(color: ProjectColors.blueActive));
  }
}