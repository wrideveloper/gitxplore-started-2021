import 'dart:async';

import 'package:buka_hero_academia/app.dart';
import 'package:buka_hero_academia/core/models/auth/profile_model.dart';
import 'package:buka_hero_academia/core/models/base_widget.dart';
import 'package:buka_hero_academia/core/services/profile_service.dart';
import 'package:buka_hero_academia/utils/palette.dart';
import 'package:buka_hero_academia/utils/transition_page.dart';
import 'package:buka_hero_academia/view/profile/list_address.dart';
import 'package:buka_hero_academia/widgets/line.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String image = '';
  String authKey = ''; 
  List<Map<String, Object>> listMenu = [
    {
      'type': 'setting_account',
      'title': 'Pengaturan Akun',
      'icon': Icons.person 
    },
    {
      'type': 'setting_addresses',
      'title': 'Pengaturan Alamat',
      'icon': Icons.location_on 
    },
    {
      'type': 'product_management',
      'title': 'Manajemen Produk',
      'icon': FontAwesome.list_alt
    }
  ];

  StreamSubscription _subscriptionName;
  ProfileModels _profileModels;
  Query _query;

  initialData() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();

    var imageData = prefs.getString('imageProfile');
    var authData = prefs.getString('auth_key');
    String imageResult = '';
    String authKeyResult = '';

    if(imageData != null || image != '') {
     imageResult = imageData;
    }
    if(authData != null || authData != '') {
      authKeyResult = authData;
    }

    setState(() { 
      image = imageResult;
      authKey = authKeyResult;
    });
    
    Provider.of<ProfileServices>(context).onEventChanged();

    Future.delayed(Duration.zero, () => Provider.of<ProfileServices>(context).getUserData());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(_subscriptionName != null) {
      _subscriptionName.cancel();
    }
  }

  _signOutUser(model) async {
    SharedPreferences refs = await SharedPreferences.getInstance();
    model.signOutRequest();

    Navigator.pushReplacement(context, PageTransition(
      child: MyApp(authKey: '',), type: PageTransitionType.fade
    ));
    refs.setString('auth_key', '');
  }

  modalLogout(BuildContext context, ProfileServices model) {
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Container(
          height: 164,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 15.0),
                child: Center(
                  child: CustomPaint(
                    size: Size(40.0, 0),
                    painter: UnderLine(
                      color: Palette.primary
                    )
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    'Anda yakin ingin keluar?',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 15.0, left: 10, right: 10),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Batal',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.bold
                            )
                          )
                        )
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => _signOutUser(model),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Palette.primary,
                            borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Keluar',
                            style: TextStyle(
                              fontSize: 14,
                              color: Palette.white,
                              fontWeight: FontWeight.bold
                            )
                          )
                        )
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        );
      }
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialData();
  }

  void _navigateSection(data) {
    print('${data["type"]} data');
    if(data["type"] == 'setting_account') {
      return null;
    } else if(data["type"] == 'setting_addresses') {
      Navigator.push(context, PageTransition(
        child: ListAddress(),
        type: PageTransitionType.fade
      ));
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileServices>(
      builder: (context, model, _) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(148),
            child: Theme(
              data: Theme.of(context).copyWith(accentColor: Palette.primary), 
              child: Container(
                decoration: BoxDecoration(
                  color: Palette.primary,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white,
                      width: 2.0
                    )
                  )
                ),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 25, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 28.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 23, bottom: 19),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: <Widget>[
                              Hero(
                                tag: 'profile', 
                                child: model.busy ?
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Palette.white,
                                      valueColor: AlwaysStoppedAnimation(Palette.primary),
                                    ),
                                  )
                                :
                                model.profileModels != null && model.profileModels.profileImage != '' ?
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(model.profileModels.profileImage)
                                      )
                                    ),
                                  )
                                :
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Palette.white
                                    ),
                                    child: Icon(
                                      FontAwesome.user_circle_o,
                                      size: 50,
                                      color: Palette.black,
                                    ),
                                  )
                              ),
                              Container( 
                                margin: EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: model.busy ?
                                      Container(
                                        // width: 7.0,
                                        height: 7.0,
                                        child: Center(
                                          child: Loading(indicator: BallPulseIndicator(), size: 50.0, color: Palette.white),
                                        ),
                                      )
                                      :
                                      model.profileModels != null && model.profileModels.name != '' ?
                                      Text(
                                        model.profileModels.name,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Palette.white,
                                          fontWeight: FontWeight.w600
                                        ),
                                      )
                                      :
                                      Text(
                                        '-',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Palette.white,
                                          fontWeight: FontWeight.w600
                                        ),
                                      )
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 3),
                                      child: model.busy ?
                                      Container(
                                        // width: 7.0,
                                        // height: 7.0,
                                        margin: EdgeInsets.only(top: 3),
                                        // color: Colors.red,
                                        alignment: Alignment.bottomCenter,
                                        child: Loading(indicator: BallPulseIndicator(), size: 14.0, color: Palette.white),
                                      )
                                      :
                                      model.profileModels != null && model.profileModels.email != '' ?
                                      Text(
                                        model.profileModels.email,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Palette.white,
                                          fontWeight: FontWeight.w600
                                        ),
                                      )
                                      :
                                      Text(
                                        '-',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Palette.white,
                                          fontWeight: FontWeight.w600
                                        ),
                                      )
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ),
                      )
                    ],
                  )
                ),
              )
            )
          ),
          body: Container(
            padding: EdgeInsets.only(top: 71, left: 23, right: 23),
            color: Palette.primary,
            child: Column(
              children: <Widget>[
                Container(
                  child: ListView(
                    shrinkWrap: true,
                    children: List.generate(
                      listMenu.length, (i) {
                        var data = listMenu[i];

                        return InkWell(
                          onTap: () =>  _navigateSection(data),
                          child: Container(
                            margin: EdgeInsets.only(top: 40),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topCenter,
                                  child: Icon(
                                    data['icon'],
                                    color: Palette.white,
                                    size: 32.0
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      '${data['title']}',
                                      style: TextStyle(
                                        color: Palette.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal
                                      ),
                                    )
                                  ),
                                ),
                                Container(
                                  child: Icon(
                                    Icons.navigate_next,
                                    color: Palette.white,
                                    size: 19.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 101.0),
                    alignment: Alignment.bottomLeft,
                    child: InkWell(
                      onTap: () => modalLogout(context, model),
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Icon(
                              Ionicons.ios_log_out,
                              color: Palette.white,
                              size: 32.0
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                'Logout',
                                style: TextStyle(
                                  color: Palette.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal
                                )
                              )
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

/* 



 */
