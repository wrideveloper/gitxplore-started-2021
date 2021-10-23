import 'package:buka_hero_academia/app.dart';
import 'package:buka_hero_academia/constants/static_variable.dart';
import 'package:buka_hero_academia/utils/palette.dart';
import 'package:buka_hero_academia/utils/transition_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Palette.primary,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  _changePage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  slideChangePage(page) {
    setState(() {
      _currentPage = page;
    });
  }

  navigateDashboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('skipOnBoarding', true);
    Navigator.pushReplacement(context, PageTransition(child: MyApp(authKey: '',), type: PageTransitionType.rotate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFFFB8C00),
                Color(0xFFFFCC80),
                Color(0xFFFFA726),
                Color(0xFFE65100),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => navigateDashboard(),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 500.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) => slideChangePage(page),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'lib/assets/img/welcome.png',
                                ),
                                height: 300.0,
                                width: 300.0,
                              ),
                            ),
                            // SizedBox(height: 20.0),
                            Text(
                              'SELAMAT DATANG\nDI ${StaticVariable.title}',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'CMSansSerif',
                                fontSize: 20.0,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Anda bisa membuka lapak penjualan atau membeli barang anda suka',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'CMSansSerif',
                                fontSize: 16.0,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'lib/assets/img/easyshop.png',
                                ),
                                height: 300.0,
                                width: 300.0,
                              ),
                            ),
                            // SizedBox(height: 20.0),
                            Text(
                              'KEMUDAHAN TRANSAKSI',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'CMSansSerif',
                                fontSize: 20.0,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Rasakan pengalaman mudahnya jual beli lewat smartphone anda',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'CMSansSerif',
                                fontSize: 16.0,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'lib/assets/img/promo.png',
                                ),
                                height: 300.0,
                                width: 300.0,
                              ),
                            ),
                            // SizedBox(height: 20.0),
                            Text(
                              'PROMO-PROMO KEREN',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'CMSansSerif',
                                fontSize: 20.0,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Banyaknya promo siap memanjakan hidup anda',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'CMSansSerif',
                                fontSize: 16.0,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () => _changePage(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () => navigateDashboard(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Ready ?',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
