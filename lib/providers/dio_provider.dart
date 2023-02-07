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
      debugPrint('Error: $error');
      return null;
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

      if (response.statusCode == 200 && response.data != '') {
        if (response.data['success']) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (error) {
      debugPrint('Registration Error: $error');
      return false;
    }
  }

  /// MAKE AN APPOINTMENT
  Future<dynamic> bookAppointment({
    required String token,
    required int doctorID,
    required String date,
    required String day,
    required String time,
  }) async {
    try {
      var response =
          await Dio().post('http://127.0.0.1:8000/api/book-appointment',
              data: {
                'doc_id': doctorID,
                'date': date,
                'day': day,
                'time': time,
              },
              options: Options(
                headers: {
                  'Accept': 'application/json',
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer $token',
                },
              ));

      if (response.statusCode == 200 && response.data != '') {
        if (response.data['success']) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (error) {
      debugPrint('Appointment Booing Error: $error');
      return false;
    }
  }
}
