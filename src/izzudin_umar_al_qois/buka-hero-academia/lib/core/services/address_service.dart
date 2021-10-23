import 'dart:async';

import 'package:buka_hero_academia/core/models/address/address_model.dart';
import 'package:buka_hero_academia/core/services/base_services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressService extends BaseServices {
  var response;
  FirebaseDatabase _database = FirebaseDatabase.instance;
  DatabaseReference itemRef;
  DataSnapshot snapshot;
  AddressModel addressModel;
  AddressList addressList;

  Future<AddressModel>getAddressData() async {
    setBusy(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('auth_key');
    try {
      // snapshot = await _database.reference().child('/addresses').orderByChild('userId').equalTo(uid).once();
      snapshot = await _database.reference().child('/addresses').orderByChild('userId').equalTo(uid).once();
      print('${snapshot.value} === value address');
      var convertData = Map<String, dynamic>.from(snapshot.value);
      addressModel = AddressModel.fromJson(convertData);
      print('${addressModel.address_label}');
      setBusy(false);
      return addressModel;
    } catch(e) {
      setBusy(false);
      throw(e);
    }
  }

  Future<String>createAddressData(AddressModel params) async {
    setBusy(true);
    params.toJson();
    print('rams === ${params.toJson()}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authKey = prefs.getString("auth_key");
    return _database.reference().child('/addresses').push().set({
      "address_label": params.address_label,
      "receiver_name": params.receiver_name,
      "phone_number": params.phone_number,
      "address_detail": params.address_detail,
      "userId": authKey
    }).then((_){
      String response = 'success';
      setBusy(false);
      return response;
    }).catchError((onError) {
      setBusy(false);
      throw(onError);
    });
  }
}