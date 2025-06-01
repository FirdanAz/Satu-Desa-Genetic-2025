import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:satu_desa/core/constant/constant.dart';
import 'package:satu_desa/features/admin/models/summary_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<SummaryModel> getSummary(String bearerToken) async {
    const String endPoint = "/dashboard-summary";
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
        return SummaryModel.fromJson(json.decode(response.body));
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
