import 'package:buka_hero_academia/app.dart';
import 'package:buka_hero_academia/core/models/auth/profile_model.dart';
import 'package:buka_hero_academia/core/services/profile_service.dart';
import 'package:buka_hero_academia/utils/palette.dart';
import 'package:buka_hero_academia/utils/transition_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCustomer extends StatefulWidget {
  @override
  _LoginCustomerState createState() => _LoginCustomerState();
}

class _LoginCustomerState extends State<LoginCustomer> {
  TextEditingController emailController;
  TextEditingController passwordController;
  bool emailIsEmpty = false;
  bool passwordIsEmpty = false;
  bool loading = false;
  bool showPassword = true;
  ProfileModels profileModels;

  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  Future<void> signInMethod(model) async {
    setLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String _email = emailController.text;
    String _password = passwordController.text;

    Map<String, dynamic> params = {
      "email": _email,
      "password": _password
    };

    if (_email.isNotEmpty && _password.isNotEmpty) {
      model.signInRequest(params).then((user) {
        prefs.setString('auth_key', user.uid);
        setLoading(false);
        showSuccessToast('Login Sukses');
        backToHome(user.uid);
      }).catchError((e) {
        setLoading(false);
        showFailedToast(e);
      });
    } else {
      setLoading(false);
      setState(() {
        emailIsEmpty = _email.isEmpty;
        passwordIsEmpty = _password.isEmpty;
      });
    }
  }

  setLoading(value) {
    setState(() {
      loading = value;
    });
  }

  signInWithGoogle(ProfileServices model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    model.signInWithGoogle().then((user) {
      model.getDataUserFromDatabase(user.uid).then((database) {
        if(database.value == null) {
          sendDataLoginIntoDatabase(user, model);
        } else {
          prefs.setString('auth_key', user.uid);
          showSuccessToast('Login Sukses');
          backToHome(user.uid);
        }
      }).catchError((err) {
        showFailedToast(err);
      });
    }).catchError((error) {
      showFailedToast(error);
    });
  }

  _signInWithFacebook(ProfileServices model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    model.signInWithFacebook().then((user) {
      model.getDataUserFromDatabase(user.uid).then((database) {
        if(database.value == null) {
          sendDataLoginIntoDatabase(user, model);
        } else {
          prefs.setString('auth_key', user.uid);
          showSuccessToast('Login Sukses');
          backToHome(user.uid);
        }
      }).catchError((err) {
        showFailedToast(err);
      });
    }).catchError((error) {
      showFailedToast(error);
    });
  }
  
  showSuccessToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIos: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white);
  }

  showFailedToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  sendDataLoginIntoDatabase(user, model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> params = {
      "name": user.displayName,
      "email": user.email,
      "password": '',
      "phone": user.phoneNumber
    };

    model.sendDataUserIntoDatabase(params, user).then((response) {
      prefs.setString('auth_key', user.uid);
      showSuccessToast('Login Sukses');
      backToHome(user.uid);
    }).catchError((err) {
      showFailedToast(err);
      backToHome(user.uid);
    });
  } 

  backToHome(String uid) {
     Navigator.pushReplacement(context, PageTransition(
       child: MyApp(authKey: uid), type: PageTransitionType.fade
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileServices>(
      builder: (context, model, _) {
        return Scaffold(
                resizeToAvoidBottomInset: false,
                body: SingleChildScrollView(
                  child: Container(
                      // height: MediaQuery.of(context).size.height / 1.2,
                      child: Container(
                          padding: EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 20,),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Column(children: <Widget>[
                                  Container(
                                    child: Image(
                                      image: AssetImage(
                                        'lib/assets/img/login.png',
                                      ),
                                      width: 259.71,
                                      height: 200.0,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Email',
                                          errorText: emailIsEmpty == true
                                              ? 'Email tidak boleh kosong!'
                                              : null),
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (val) {
                                        setState(() {
                                          emailIsEmpty = false;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: TextField(
                                      obscureText: showPassword,
                                      decoration: InputDecoration(
                                          hintText: 'Password',
                                          suffixIcon: InkWell(
                                            onTap: () {
                                              if(showPassword != true) {
                                                setState(() {
                                                  showPassword = true;
                                                });
                                              } else {
                                                setState(() {
                                                  showPassword = false;
                                                });
                                              }
                                            },
                                            child: Icon(
                                              showPassword == true ? Icons.visibility_off : Icons.visibility,
                                              size: 25,
                                            ),
                                          ),
                                          errorText: passwordIsEmpty == true
                                              ? 'Password tidak boleh kosong!'
                                              : null),
                                      controller: passwordController,
                                      keyboardType: TextInputType.text,
                                      onChanged: (val) {
                                        setState(() {
                                          passwordIsEmpty = false;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: RaisedButton(
                                        color: Palette.primary,
                                        onPressed: () => signInMethod(model),
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Center(
                                            child: loading ?
                                            SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(
                                                backgroundColor: Palette.white,
                                                valueColor: AlwaysStoppedAnimation(Palette.primary),
                                              ),
                                            )
                                            :
                                            Text(
                                              'Masuk',
                                              style: TextStyle(color: Colors.white)
                                            ),
                                          ),
                                        )),
                                  )
                                ]),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 68),
                                  child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Container(
                                            color: Colors.black,
                                            height: 01.0,
                                            width: 76,
                                          ),
                                          Text('Masuk cepat dengan',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300
                                            ),
                                          ),
                                          Container(
                                            color: Colors.black,
                                            height: 01.0,
                                            width: 76,
                                          ),
                                        ]),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () => signInWithGoogle(model),
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(50)),
                                                    border: Border.all(
                                                      color: Colors.black12,
                                                    )),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Image(
                                                      image: AssetImage(
                                                          'lib/assets/img/google.png'),
                                                      width: 20,
                                                      height: 20),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () => _signInWithFacebook(model),
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(50)),
                                                    border: Border.all(
                                                      color: Colors.black12,
                                                    )),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Image(
                                                      image: AssetImage(
                                                          'lib/assets/img/facebook.png'),
                                                      width: 20,
                                                      height: 20),
                                                ),
                                              ),
                                            ),
                                          ]))
                                ],
                              ))
                            ],
                          ))),
                ),
              );
      },
    );
  }
}
