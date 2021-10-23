import 'package:flutter/material.dart';

class BaseServices extends ChangeNotifier {
  bool _busy = false;
  bool _busyLoadmore = false;
  bool _busyUpload = false;
  bool _busyCreate = false;
  bool _busyRequest = false;

  bool get busy => _busy;
  bool get busyLoadmore => _busyLoadmore;
  bool get busyUpload => _busyUpload;
  bool get busyCreate => _busyCreate;
  bool get busyRequest => _busyRequest;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  void setBusyLoadmore(bool value) {
    _busyLoadmore = value; 
    notifyListeners();
  }

  void setBusyUpload(bool value) {
    _busyUpload = value;
    notifyListeners();
  }

  void setBusyCreate(bool value) {
    _busyCreate = value;
    notifyListeners();
  }

  void setBusyRequest(bool value) {
    _busyRequest = value;
    notifyListeners();
  }
}
