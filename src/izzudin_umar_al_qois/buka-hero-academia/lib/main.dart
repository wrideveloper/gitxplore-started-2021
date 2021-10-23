import 'package:buka_hero_academia/constants/static_routePaths.dart';
import 'package:buka_hero_academia/constants/static_variable.dart';
import 'package:buka_hero_academia/core/services/address_service.dart';
import 'package:buka_hero_academia/core/services/profile_service.dart';
import 'package:buka_hero_academia/router.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

void main() {
  Lottie.traceEnabled = true;
  runApp(Main());
}

class Main extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProfileServices>(
          create: (context) => ProfileServices()
        ),
        ChangeNotifierProvider<AddressService>(
          create: (context) => AddressService()
        ),
      ],
      child: MaterialApp(
      title: StaticVariable.title,
      theme: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          initialRoute: RoutePaths.Splash,
          onGenerateRoute: Router.generate,
      )
    );
  }
}
