import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioProvider {
  /// GET TOKEN USING GMAIL & PASSWORD
  Future<dynamic> getToken({
    required String email,
    required String password,
  }) async {
    try {
      var response = await Dio().post('http://127.0.0.1:8000/api/login',
          data: {
            'email': email,
            'password': password,
          },
          options: Options(
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
          ));

      if (response.statusCode == 200) {
        if (response.data['success']) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('token', response.data['message']);
          return true;
        } else {
          debugPrint('ERROR: ${response.data['message']}');
          return false;
        }
      } else {
        return false;
      }
    } catch (error) {
      debugPrint('LOGIN ERROR: $error');
      return false;
    }
  }

  /// GET USER DATA
  Future<dynamic> getUser({required String token}) async {
    try {
      var userResponse = await Dio().get(
        'http://127.0.0.1:8000/api/user',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        }),
      );

      if (userResponse.statusCode == 200 && userResponse.data != '') {
        return json.encode(userResponse.data);
      }
    } catch (error) {
      return error;
    }
  }

  /// REGISTER A NEW USER
  Future<dynamic> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      var response = await Dio().post('http://127.0.0.1:8000/api/register',
          data: {
            'name': name,
            'email': email,
            'password': password,
          },
          options: Options(
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
          ));

      if (response.statusCode == 201 && response.data != '') {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return error;
    }
  }
}
