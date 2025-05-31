import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:satu_desa/core/constant/constant.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<bool> checkMyRequest(String bearerToken) async {
    const String endPoint = "/desa/my-request";
    const String url = "${Constant.baseUrl}$endPoint";

    final Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $bearerToken",
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

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

  static Future<bool> postJoinDesa(String bearerToken, String kodeDesa) async {
    const String endPoint = "/desa/request-join";
    const String url = "${Constant.baseUrl}$endPoint";

    print(kodeDesa);

    final Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $bearerToken",
    };

    final Map<String, String> body = {
      "kode_desa": kodeDesa,
    };

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

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
