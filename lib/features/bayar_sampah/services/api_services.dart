import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:satu_desa/core/constant/constant.dart';
import 'package:satu_desa/features/bayar_sampah/models/history_transaksi_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<List<HistoryTransaksiModel>> getHistoryTransaksi(
      String bearerToken) async {
    const String endPoint = "/sampah/history/transaksi";
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
        return historyTransaksiModelFromJson(response.body);
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

  static Future<String> postCretePayment(String year, String month, String bearerToken) async {
    const String endPoint = "/sampah/bayar";
    const String url = "${Constant.baseUrl}$endPoint";

    final Map<String, String> body = {
      "year": year,
      "month" : month
    };

    final Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $bearerToken",
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: headers,
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return json.decode(response.body)["snap_token"];
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
