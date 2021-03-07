import 'package:flutter/services.dart';
import 'package:twitter_clone/views/resources/colors.dart';

class Graphical {
  static void setSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        // systemNavigationBarDividerColor: ProjectColors.grayDivider,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: ProjectColors.white,
        statusBarBrightness: Brightness.light,
        statusBarColor: ProjectColors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  static Future<void> setPreferredOrientations() {
    return SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }
}
