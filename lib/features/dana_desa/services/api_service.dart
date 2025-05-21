import 'dart:async';
import 'dart:io';

import 'package:satu_desa/core/constant/constant.dart';
import 'package:satu_desa/features/dana_desa/models/dana_desa_model.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ApiService {
   static Future<DanaDesaModel> getHistoryTransaksi(
      String bearerToken) async {
    const String endPoint = "/dana-desa/dana";
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
        return danaDesaModelFromJson(response.body);
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
