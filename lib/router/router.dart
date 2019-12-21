import 'package:flutter/material.dart';
import 'package:hackai/router/route_paths.dart' as routes;
import 'package:hackai/src/view/login/AuthScreen.dart';
import 'package:hackai/src/view/main/main_screen.dart';
import 'package:hackai/src/view/profile/categories/categories_screen.dart';
import 'package:hackai/src/view/splash/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  MaterialPageRoute getPageRoute(Widget screen) {
    return MaterialPageRoute(builder: (context) => screen, settings: settings);
  }

  switch (settings.name) {
    case routes.splashRoute:
      return getPageRoute(SplashScreen());
    case routes.mainRoute:
      return getPageRoute(MainScreen());
    case routes.categoriesRoute:
      return getPageRoute(CategoriesScreen());
    case routes.loginRoute:
      return getPageRoute(AuthScreen());

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No screen for ${settings.name} path'),
          ),
        ),
      );
  }
}
