import 'package:buka_hero_academia/core/models/base_widget.dart';
import 'package:buka_hero_academia/core/services/profile_service.dart';
import 'package:buka_hero_academia/utils/palette.dart';
import 'package:buka_hero_academia/utils/transition_page.dart';
import 'package:buka_hero_academia/view/auth/login.dart';
import 'package:buka_hero_academia/view/main/dashboards.dart';
import 'package:buka_hero_academia/view/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  String authKey;

  MyApp({ this.authKey });
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  PageController pageController;
  String image = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _onChangeScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToScreen(int index) {
    pageController.jumpToPage(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToProfile() {
    if(widget.authKey != '') {
      Navigator.push(
      context,
      PageTransition(
        child: Profile(),
        type: PageTransitionType.downToUp,
      ),
    );
    } else {
      Navigator.push(context,
        PageTransition(child: Login(), type: PageTransitionType.downToUp)
      );
    }
  }

@override
  Widget build(BuildContext context) {
    return BaseWidget<ProfileServices>(
      onModelReady: (model) => model.getUserData(),
      model: ProfileServices(),
      builder: (context, model, _) {
        return Scaffold(
            body: PageView(
              controller: pageController,
              onPageChanged: (int index) => _onChangeScreen(index),
              children: <Widget>[
                Dashboards(),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              child: Container(
                height: 56.0,
                child: Row(
                  children: <Widget> [
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () => _navigateToScreen(0),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.dashboard,
                                color: _selectedIndex != 0 ? Palette.black10 : Palette.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () => _navigateToProfile(),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Hero(
                                tag: 'profile',
                                child: model.busy == true ?
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Palette.white,
                                      valueColor: AlwaysStoppedAnimation(Palette.primary),
                                    ),
                                  )
                                :
                                 model.profileModels != null && model.profileModels.profileImage != '' ?
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(model.profileModels.profileImage)
                                      )
                                    ),
                                  )
                                  :
                                  Icon(
                                    FontAwesome.user_circle_o,
                                  )
                                ,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ]
                )
              )
            ) 
          );
      },
    );
  }
}
