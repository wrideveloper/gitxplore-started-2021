import 'package:buka_hero_academia/constants/static_routePaths.dart';
import 'package:buka_hero_academia/utils/transition_page.dart';
import 'package:buka_hero_academia/view/widget/splash.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Splash:
        return PageTransition(child: SplashScreen(), type: PageTransitionType.fade);
        break;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
