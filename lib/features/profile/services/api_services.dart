import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:satu_desa/core/constant/constant.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:satu_desa/features/home_page/models/profile_model.dart';

class ApiServices {
  static Future<ProfileModel> getProfile(String bearerToken) async {
    const String endPoint = "/user-getdata";
    const String url = "${Constant.baseUrl}$endPoint";

    final Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $bearerToken",
    };

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return ProfileModel.fromJson(json.decode(response.body));
      } else {
        throw Exception(
            "Get Profile failed with status code: ${response.statusCode}");
      }
    } on SocketException {
      throw const SocketException("No Internet connection");
    } on TimeoutException {
      throw TimeoutException("Request timed out");
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> postLogout(String bearerToken) async {
    const String endPoint = "/logout";

    const String url = "${Constant.baseUrl}$endPoint";

    final Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $bearerToken",
    };
    try {
      await http.post(Uri.parse(url), headers: headers);
      return;
    } on SocketException {
      throw const SocketException("");
    } on TimeoutException {
      throw TimeoutException("");
    } catch (e) {
      rethrow;
    }
  }
}
