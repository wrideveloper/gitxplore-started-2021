

import 'dart:async';

import 'package:buka_hero_academia/core/models/auth/profile_model.dart';
import 'package:buka_hero_academia/core/services/base_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileServices extends BaseServices {
  var response;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseDatabase _database = FirebaseDatabase.instance;
  FacebookLogin facebookLogin = new FacebookLogin();
  ProfileModels _profileModels;
  DataSnapshot _snapshot;
  DatabaseReference itemRef;
  FirebaseUser _user;


  get snapshot => _snapshot;
  get profileModels => _profileModels;

  onEventChanged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('auth_key');
    itemRef = _database.reference().child('/users/$uid');

    itemRef.onValue.listen(_onEntryChanged);
  }

  _onEntryChanged(Event event) {
    var convertData = Map<String, dynamic>.from(event.snapshot.value);
    _profileModels = ProfileModels.fromJson(convertData);
    notifyListeners();
  }

  Future<FirebaseUser>registerRequest(Map<String, dynamic> params) async {
    String email = params["email"];
    String password = params["password"];
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = authResult.user;

      return user;
    } catch (e) {
      throw(e);
    }
  }

  Future<FirebaseUser>signInRequest(Map<String, dynamic> params) async {
    String email = params["email"];
    String password = params["password"];

    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = authResult.user;

      return user;
    } catch (e) {
      throw(e.message);
    }
  }

  Future<FirebaseUser>signInWithGoogle() async {
    setBusy(true);

    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      AuthResult authResult = await _auth.signInWithCredential(credential);
      FirebaseUser user = authResult.user;

      setBusy(false);
      return user;
    } catch (e) {
      setBusy(false);
      throw(e.message);
    }
  }

  Future<FirebaseUser>signInWithFacebook() async {
    try {
      FacebookLoginResult facebookLoginResult = await _handleFbSignIn();
      FacebookAccessToken accessToken = facebookLoginResult.accessToken;
      final token = accessToken.token;
      final facebookAuthCred = FacebookAuthProvider.getCredential(accessToken: token);
      AuthResult authResult = await _auth.signInWithCredential(facebookAuthCred);
      FirebaseUser user = authResult.user;
      print('${user.uid} == isUser');

      setBusy(false);
      return user;
    } catch(e) {
      setBusy(false);
      throw(e.message);
    }
  }

  Future<FacebookLoginResult> _handleFbSignIn() async {
    FacebookLoginResult facebookLoginResult = await facebookLogin.logIn(['email']);

    return facebookLoginResult;
  }

  Future<DataSnapshot>getDataUserFromDatabase(String uid) async {
    try {
      _snapshot = await _database.reference().child('/users/$uid').once();
      return _snapshot;
    } catch(e) {
      throw(e.message);
    }
  }

  Future<ProfileModels>getUserData() async {
    setBusy(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('auth_key');
    try {
      _snapshot = await _database.reference().child('/users/$uid').once();
      var convertData = Map<String, dynamic>.from(_snapshot.value);
      _profileModels = ProfileModels.fromJson(convertData);
      setBusy(false);
      return _profileModels;
    } catch(e) {
      setBusy(false);
      throw(e.message);
    }
  }

  Future<Query>getQueryProfile() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('auth_key');

    return _database.reference().child('/users/$uid');
  }

  Future<String>sendDataUserIntoDatabase(Map<String, dynamic> params, FirebaseUser user) async {
   return _database.reference().child('/users/${user.uid}').set({
      "name": params['name'],
      "email": params['email'],
      "phone": params['phone'] != null ? params['phone'] : '',
      "profileImage": user.photoUrl != null ? user.photoUrl : '',
    }).then((_){
      String response = 'success';
      return response;
    }).catchError((onError) {
      throw (onError);
    });
  }

  updateDataUserIntoDatabase(FirebaseUser user) async {
    _database.reference().child('/users/${user.uid}/').update({
      "name": user.displayName,
      "email": user.email,
      "phone": user.phoneNumber != null ? user.phoneNumber : '',
      "profileImage": user.photoUrl,
    }).then((value) {
    }).catchError((onError) {
      throw (onError.message);
    });
  }

  signOutRequest() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await facebookLogin.logOut();
    await googleSignIn.signOut();
    await _auth.signOut();
    _user = null;
  }
}