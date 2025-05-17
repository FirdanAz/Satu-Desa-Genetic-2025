import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:satu_desa/core/constant/constant.dart';
import 'package:satu_desa/features/login/models/login_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<LoginModel> postLogin(String email, String password) async {
    const String endPoint = "/login";
    const String url = "${Constant.baseUrl}$endPoint";

    final Map<String, String> body = {
      "email": email,
      "password": password,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {"Accept": "application/json"},
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return LoginModel.fromJson(json.decode(response.body));
      } else {
        throw Exception(
            "Login failed with status code: ${response.statusCode}");
      }
    } on SocketException {
      throw const SocketException("No Internet connection");
    } on TimeoutException {
      throw TimeoutException("Request timed out");
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> sendOtp(String bearerToken, String email) async {
    const String endPoint = "/send-otp";
    const String url = "${Constant.baseUrl}$endPoint";
    final Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $bearerToken",
    };
    final Map<String, String> body = {
      "email": email,
    };

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        bool status = json.decode(response.body)["status"];

        return status == true ? true : false;
      } else {
        print("Unexpected response: ${response.statusCode}");
        return false;
      }
    } on SocketException catch (e) {
      print('SocketException: $e');
      return false;
    } on TimeoutException {
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> verifyOtp(String bearerToken, String email, String otp) async {
    const String endPoint = "/verify-otp";
    const String url = "${Constant.baseUrl}$endPoint";
    final Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $bearerToken",
    };
    final Map<String, String> body = {
      "email": email,
      "otp": otp,
    };

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        bool status = json.decode(response.body)["status"];

        return status == true ? true : false;
      } else {
        print("Unexpected response: ${response.statusCode}");
        return false;
      }
    } on SocketException catch (e) {
      print('SocketException: $e');
      return false;
    } on TimeoutException {
      return false;
    } catch (e) {
      return false;
    }
  }
}
