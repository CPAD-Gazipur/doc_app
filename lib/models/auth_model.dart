import 'dart:convert';

import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  bool _isLogin = false;

  Map<String, dynamic> user = {};
  Map<String, dynamic> appointment = {};

  List<Map<String, dynamic>> favoriteDoctor = [];

  List<dynamic> _favoriteDoctor = [];

  bool get isLogin => _isLogin;

  List<dynamic> get getFavorite => _favoriteDoctor;

  Map<String, dynamic> get getUser => user;

  Map<String, dynamic> get getAppointment => appointment;

  List<Map<String, dynamic>> get getFavoriteDoctor {
    favoriteDoctor.clear();

    for (var num in _favoriteDoctor) {
      for (var doc in user['doctors']) {
        if (num == doc['doc_id']) {
          favoriteDoctor.add(doc);
        }
      }
    }

    return favoriteDoctor;
  }

  void loginSuccess({
    required Map<String, dynamic> userData,
    required Map<String, dynamic> appointmentInfo,
  }) {
    _isLogin = true;
    user = userData;
    appointment = appointmentInfo;
    if (user['details']['favorite'] != null) {
      _favoriteDoctor = json.decode(user['details']['favorite']);
    }
    notifyListeners();
  }

  void setFavorite(List<dynamic> list) {
    _favoriteDoctor = list;
    notifyListeners();
  }
}
