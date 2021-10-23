import 'dart:async';

import 'package:buka_hero_academia/app.dart';
import 'package:buka_hero_academia/onboarding_screen.dart';
import 'package:buka_hero_academia/utils/transition_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () =>  _initialGetDataFirebase());

  }

  void _initialGetDataFirebase() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool skipOnBoarding = prefs.getBool('skipOnBoarding');
    if (skipOnBoarding == true) {
      FirebaseUser firebaseUser = await _auth.currentUser();

      String key = '';
      if(firebaseUser != null) {
        key = firebaseUser.uid;
        prefs.setString('auth_key', key);
      } else {
        prefs.remove('auth_key');
      }

      Navigator.push(context, PageTransition(child: MyApp(authKey: key,), type: PageTransitionType.leftToRight));
    } else {
      Navigator.push(context, PageTransition(
        type: PageTransitionType.leftToRight,
        child: OnBoardingScreen()
      ));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Container(
                  child: Center(
                      child: Lottie.asset(
                'lib/assets/animations/sand_clock_animations.json',
                width: 200,
                height: 200,
                fit: BoxFit.fill,
              ))),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30, left: 103, right: 102.31),
              child: Image(
                  image: AssetImage('lib/assets/img/logo.png'),
                  width: 154.69,
                  height: 50.00),
            )
          ],
        ),
      ),
    );
  }
}
