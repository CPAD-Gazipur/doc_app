import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doc_app/services/services.dart';
import 'package:flutter/material.dart';

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
          await SharedPreferencesService.saveToken(
            token: response.data['message'],
          );
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

  /// LOGOUT USER
  Future<bool> logout({
    required String token,
  }) async {
    try {
      var response = await Dio().post('http://127.0.0.1:8000/api/logout',
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
      debugPrint('Appointment Completing Error: $error');
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

  /// GET USER APPOINTMENTS
  Future<dynamic> getAppointments({required String token}) async {
    try {
      var appointmentsResponse = await Dio().get(
        'http://127.0.0.1:8000/api/appointments',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        }),
      );

      if (appointmentsResponse.statusCode == 200 &&
          appointmentsResponse.data != '') {
        return json.encode(appointmentsResponse.data);
      }
    } catch (error) {
      debugPrint('AppointmentsError: $error');
      return null;
    }
  }

  /// STORE REVIEW & COMPLETE APPOINTMENT
  Future<dynamic> storeReviewAndCompleteAppointment({
    required String token,
    required int appointmentID,
    required int doctorID,
    required double ratings,
    required String reviews,
  }) async {
    try {
      var response =
          await Dio().post('http://127.0.0.1:8000/api/complete-appointment',
              data: {
                'appointment_id': appointmentID,
                'doctor_id': doctorID,
                'ratings': ratings,
                'reviews': reviews,
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
      debugPrint('Appointment Completing Error: $error');
      return false;
    }
  }

  /// STORE FAVORITE DOCTOR
  Future<bool> storeFavoriteDoctor({
    required String token,
    required List<dynamic> favoriteDoctors,
  }) async {
    try {
      var response =
          await Dio().post('http://127.0.0.1:8000/api/store-favorite',
              data: {
                'favoriteDoctorList': favoriteDoctors,
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
      debugPrint('Appointment Completing Error: $error');
      return false;
    }
  }
}
