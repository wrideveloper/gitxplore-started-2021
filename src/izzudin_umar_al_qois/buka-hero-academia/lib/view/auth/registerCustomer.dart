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

class RegisterCustomer extends StatefulWidget {
  @override
  _RegisterCustomerState createState() => _RegisterCustomerState();
}

class _RegisterCustomerState extends State<RegisterCustomer> {
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController nameController;
  TextEditingController phoneController;
  bool emailIsEmpty = false;
  bool passwordIsEmpty = false;
  bool showPassword = true;
  bool nameIsEmpty = false;
  bool phoneIsEmpty = false;
  bool loading = false;
  ProfileModels profileModels;

  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    super.initState();
  }

  Future<void> registerMethod(model) async {
    setState(() {
      loading = true;
    });
    String _email = emailController.text;
    String _password = passwordController.text;
    String _name = nameController.text;
    String _phone = phoneController.text;


    if (_email.isNotEmpty && _password.isNotEmpty && _name.isNotEmpty && _phone.isNotEmpty) {
      Map<String, dynamic> params = {
        "name": _name,
        "email": _email,
        "password": _password,
        "phone": _phone
      };

      model.registerRequest(params).then((user) {
        print('user object == ${user.uid}');
        sendDataLoginIntoDatabase(user, model, params);
      }).catchError((e) {
        print(e);
        setLoading(false);
        showFailedToast('Registrasi Gagal === $e');
      });
    } else {
      setState(() {
        emailIsEmpty = _email.isEmpty;
        passwordIsEmpty = _password.isEmpty;
        nameIsEmpty = _name.isEmpty;
        phoneIsEmpty = _phone.isEmpty;
      });
      setLoading(false);
    }
  }

  setLoading(value) {
    setState(() {
      loading = value;
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
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  sendDataLoginIntoDatabase(user, model, params) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    model.sendDataUserIntoDatabase(params, user).then((response) {
      setLoading(false);
      prefs.setString('auth_key', user.uid);
      showSuccessToast('Login Sukses');
      backToHome(user.uid);
    }).catchError((err) {
      setLoading(false);
      showFailedToast(err);
      backToHome(user.uid);
    });
  }

  backToHome(String uid) {
    Navigator.pushReplacement(
        context,
        PageTransition(
            child: MyApp(authKey: uid), type: PageTransitionType.fade));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileServices>(
      builder: (context, model, _) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Container(
                child: Container(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: 40,
                      right: 40,
                      bottom: 20,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Column(children: <Widget>[
                            Container(
                              child: Image(
                                image: AssetImage(
                                  'lib/assets/img/imageRegister.png',
                                ),
                                width: 259.71,
                                height: 200.0,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: 'Nama Lengkap',
                                    errorText: nameIsEmpty == true
                                        ? 'Nama tidak boleh kosong!'
                                        : null),
                                controller: nameController,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                onChanged: (val) {
                                  setState(() {
                                    nameIsEmpty = false;
                                  });
                                },
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
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: 'Phone',
                                    errorText: phoneIsEmpty == true
                                        ? 'Phone tidak boleh kosong!'
                                        : null),
                                controller: phoneController,
                                keyboardType: TextInputType.number,
                                onChanged: (val) {
                                  setState(() {
                                    phoneIsEmpty = false;
                                  });
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: RaisedButton(
                                  color: Palette.primary,
                                  onPressed: () => registerMethod(model),
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
                                        'Daftar',
                                        style: TextStyle(color: Colors.white)
                                      ),
                                    ),
                                  )),
                            )
                          ]),
                        ),
                      ],
                    ))),
          ),
        );
      },
    );
  }
}
