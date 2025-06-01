import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:satu_desa/core/constant/constant.dart';
import '../models/meeting_model.dart';

class ApiService {
  Future<List<MeetingModel>> getMeetings(String bearerToken) async {
    const String endPoint = "/meetings";
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
        return meetingModelFromJson(response.body);
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

  Future<MeetingModel> getMeetingDetail(int id, String bearerToken) async {
    final String endPoint = "/meetings/$id";
    final String url = "${Constant.baseUrl}$endPoint";

    final Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $bearerToken",
    };

    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    return MeetingModel.fromJson(json.decode(response.body));
  }

  Future<Map<String, dynamic>> getMeetingResult(
      int id, String bearerToken) async {
    final String endPoint = "/meetings/$id/result";
    final String url = "${Constant.baseUrl}$endPoint";

    final Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $bearerToken",
    };

    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    return json.decode(response.body);
  }

  Future<MeetingModel> createMeeting(
      Map<String, dynamic> data, String bearerToken) async {
    final String endPoint = "/meetings";
    final String url = "${Constant.baseUrl}$endPoint";

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

      if (response.statusCode == 200 || response.statusCode == 201) {
        return MeetingModel.fromJson(json.decode(response.body));
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
}
