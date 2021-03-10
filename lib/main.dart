// @dart=2.9
import 'package:flutter/material.dart';

import 'config/app_config.dart';
import 'views/graphical.dart';
import 'views/routes.dart';
import 'config/di.dart';
import 'views/resources/colors.dart';
import 'views/resources/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Graphical.setSystemUIOverlayStyle();
  await Graphical.setPreferredOrientations();

  // await InitService.init();
  runApp(Di.init(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConfig.projectName,
      routes: Routes.routes,
      theme: ThemeData(
        primaryColor: ProjectColors.blueActive,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryIconTheme: IconThemeData(color: ProjectColors.blueActive),
        appBarTheme: AppBarTheme(
          color: ProjectColors.white,
        ),
        textTheme: TextTheme(bodyText2: Styles.body2),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(primary: ProjectColors.blueActive),
        ),
        typography: Typography.material2018(),
      ),
      initialRoute: Routes.preload
    );
  }
}
