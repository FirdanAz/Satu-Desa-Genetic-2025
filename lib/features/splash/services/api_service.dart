import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:satu_desa/core/constant/constant.dart';

class ApiService {
  static Future<bool> tokenValidate(String bearerToken) async {
    const String endPoint = "/me";
    const String url = "${Constant.baseUrl}$endPoint";
    final Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $bearerToken",
    };

    try {
      print(bearerToken);
      final response = await http.get(Uri.parse(url), headers: headers);

      print(response.body);

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
