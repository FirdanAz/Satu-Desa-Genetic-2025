import 'dart:async';
import 'dart:io';

import 'package:satu_desa/core/constant/constant.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<bool> postRegister(String userName, String email, String password) async {
    const String endPoint = "/register";
    const String url = "${Constant.baseUrl}$endPoint";

    final Map<String, String> body = {
      "name": userName,
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

      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception(
            "Register failed with status code: ${response.statusCode}");
      }
    } on SocketException {
      throw const SocketException("No Internet connection");
    } on TimeoutException {
      throw TimeoutException("Request timed out");
    } catch (e) {
      rethrow;
    }
  }
}