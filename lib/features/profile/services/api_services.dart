import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:satu_desa/core/constant/constant.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:satu_desa/features/home_page/models/profile_model.dart';
import 'package:satu_desa/features/profile/models/village_model.dart';
import 'package:satu_desa/features/profile/models/location_model.dart';

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

  static Future<bool> fillData(
      {required String kartuKeluarga,
      required String nomorInduk,
      required String nomorTelp,
      required String address,
      required String bearerToken}) async {
    const String endPoint = "/user-filldata";
    const String url = "${Constant.baseUrl}$endPoint";

    final Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $bearerToken",
    };

    final Map<String, String> body = {
      "nomor_induk_kependudukan": nomorInduk,
      "kartu_keluarga": kartuKeluarga,
      "phone_number": nomorTelp,
      "address": address,
      "status": "active"
    };

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return true;
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

  static Future<bool> updateLocation(
      {required String provinsi,
      required String kabupaten,
      required String kecamatan,
      required String desa,
      required String bearerToken}) async {
    const String endPoint = "/user/location";
    const String url = "${Constant.baseUrl}$endPoint";

    final Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $bearerToken",
    };

    final Map<String, String> body = {
      "provinsi": provinsi,
      "kabupaten": kabupaten,
      "kecamatan": kecamatan,
      "desa": desa
    };

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return true;
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

  static Future<LocationModel> getProvinces() async {
    const String url = "https://wilayah.id/api/provinces.json";

    final Map<String, String> headers = {"Accept": "application/json"};

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return LocationModel.fromJson(json.decode(response.body));
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

  static Future<LocationModel> getRegencies(String provinceId) async {
    String url = "https://wilayah.id/api/regencies/$provinceId.json";

    final Map<String, String> headers = {"Accept": "application/json"};

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return LocationModel.fromJson(json.decode(response.body));
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

  static Future<LocationModel> getDistricts(String regencyId) async {
    String url = "https://wilayah.id/api/districts/$regencyId.json";

    final Map<String, String> headers = {"Accept": "application/json"};

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return LocationModel.fromJson(json.decode(response.body));
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

  static Future<DistricModel> getVillages(String districId) async {
    String url = "https://wilayah.id/api/villages/$districId.json";

    final Map<String, String> headers = {"Accept": "application/json"};

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return DistricModel.fromJson(json.decode(response.body));
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
