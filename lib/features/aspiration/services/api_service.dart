import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:satu_desa/core/constant/constant.dart';
import 'package:satu_desa/features/aspiration/models/aspirasi_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<AspirasiModel>> getAspirasi(String bearerToken) async {
    const String endPoint = "/aspirasi";
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
        return aspirasiModelFromJson(response.body);
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

  static Future<bool> postAspirasi({
    required String bearerToken,
    required String judul,
    required String deskripsi,
    required String lokasi,
    List<File>? images,
    bool anonim = false,
  }) async {
    const String endPoint = "/aspirasi";
    final Uri url = Uri.parse("${Constant.baseUrl}$endPoint");

    print(images);

    try {
      final request = http.MultipartRequest('POST', url)
        ..headers.addAll({
          "Accept": "application/json",
          "Authorization": "Bearer $bearerToken",
        })
        ..fields['judul'] = judul
        ..fields['deskripsi'] = deskripsi
        ..fields['lokasi'] = lokasi
        ..fields['anonim'] = anonim ? '1' : '0';

      // Tambahkan setiap file gambar
      if (images != null) {
        for (var image in images) {
          final fileStream = http.ByteStream(image.openRead());
          final length = await image.length();

          final multipartFile = http.MultipartFile(
            'images[]', // penting: tetap pakai images[]
            fileStream,
            length,
            filename: image.path.split('/').last,
          );

          request.files.add(multipartFile);
        }
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print("Status Code: ${response.statusCode}");
      print("Response Body: $responseBody");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonBody = json.decode(responseBody);
        return jsonBody['status'] == true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  static Future<bool> updateAspirasi({
    required String bearerToken,
    required int aspirasiId,
    required String judul,
    required String deskripsi,
    required String lokasi,
    required bool anonim,
    List<File>? newImages,
    List<int>? retainedImageIds, // ID gambar lama yang tetap disimpan
  }) async {
    final String endPoint = "/aspirasi/$aspirasiId";
    final Uri url = Uri.parse("${Constant.baseUrl}$endPoint");

    try {
      final request = http.MultipartRequest('POST', url)
        ..headers.addAll({
          "Accept": "application/json",
          "Authorization": "Bearer $bearerToken",
          // Jika backend perlu spoofing method
        });

      // Hanya tambahkan field yang tidak null
      request.fields['judul'] = judul;
      request.fields['deskripsi'] = deskripsi;
      request.fields['lokasi'] = lokasi;
      request.fields['anonim'] = anonim ? '1' : '0';

      print("Judul : $judul");

      // Tambahkan gambar baru
      if (newImages != null) {
        for (var image in newImages) {
          final fileStream = http.ByteStream(image.openRead());
          final length = await image.length();

          final multipartFile = http.MultipartFile(
            'images[]',
            fileStream,
            length,
            filename: image.path.split('/').last,
          );

          request.files.add(multipartFile);
        }
      }

      // Kirim ID gambar lama yang tetap ingin disimpan (opsional)
      if (retainedImageIds != null && retainedImageIds.isNotEmpty) {
        for (var id in retainedImageIds) {
          request.fields['retained_image_ids[]'] = id.toString();
        }
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print("Status Code: ${response.statusCode}");
      print("Response Body: $responseBody");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonBody = json.decode(responseBody);
        return jsonBody['status'] == true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  static Future<bool> deleteAspirasi(
      {required String bearerToken, required int aspirasiId}) async {
    final String endPoint = "/aspirasi/$aspirasiId";
    String url = "${Constant.baseUrl}$endPoint";

    final Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $bearerToken",
    };
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
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

  static Future<bool> deleteImageAspirasi(
      {required String bearerToken, required int imageId}) async {
    final String endPoint = "/aspirasi/image/$imageId";
    String url = "${Constant.baseUrl}$endPoint";

    final Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $bearerToken",
    };
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
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
}
