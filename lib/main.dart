import 'package:flutter/material.dart';
import 'package:twitter_clone/views/pages/preload_page.dart';

import 'config/app_config.dart';
import 'config/graphical.dart';
import 'config/routes.dart';
import 'di/di.dart';
import 'services/init_service.dart';
import 'views/resources/colors.dart';
import 'views/resources/styles.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Graphical.setSystemUIOverlayStyle();
  Graphical.setPreferredOrientations();

  InitService.init().then(
    (value) => runApp(
      Di.init(MyApp())
    ),
  );
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
          typography: Typography.material2018()),
      home: PreloadPage(),
    );
  }
}
