import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class LocalDataPersistance {
  static final LocalDataPersistance _instance = LocalDataPersistance._internal();
  static SharedPreferences? _prefs;

  // Singleton
  LocalDataPersistance._internal();
  factory LocalDataPersistance() => _instance;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<void> clear() async {
    await _prefs?.clear();
  }

  static Future<void> clearWithout(List<String> keys) async {
    Set<String> currentKeys = {
      "bearer_token",
      "user_name",
      "user_id",
      "user_role",
      "user_email",
      "user_phone",
      "user_nik",
      "user_city"
    };

    currentKeys.removeAll(keys.toSet());

    await Future.wait(currentKeys.map((key) => _prefs!.remove(key)));
  }

  String? getBearerToken() => _prefs?.getString("bearer_token");

  String? getUserName() => _prefs?.getString("user_name");

  String? getUserId() => _prefs?.getString("user_id");

  String? getUserRole() => _prefs?.getString("user_role");

  String? getUserEmail() => _prefs?.getString("user_email");

  String? getUserPhone() => _prefs?.getString("user_phone");

  String? getUserNik() => _prefs?.getString("user_nik");

  String? getUserCity() => _prefs?.getString("user_city");

  Future<void> setBearerToken(String token) async {
    await _prefs?.setString("bearer_token", token);
  }

  Future<void> setUserName(String userName) async {
    await _prefs?.setString("user_name", userName);
  }

  Future<void> setUserId(String userId) async {
    await _prefs?.setString("user_id", userId);
  }

  Future<void> setUserRole(String userRole) async {
    await _prefs?.setString("user_role", userRole);
  }

  Future<void> setUserEmail(String userEmail) async {
    await _prefs?.setString("user_email", userEmail);
  }
  
  Future<void> setUserPhone(String userPhone) async {
    await _prefs?.setString("user_phone", userPhone);
  }

  Future<void> setUserNik(String userNik) async {
    await _prefs?.setString("user_nik", userNik);
  }

  Future<void> setUserCity(String userCity) async {
    await _prefs?.setString("user_nik", userCity);
  }

  Future<void> removeBearerToken() async {
    await _prefs?.remove("bearer_token");
  }
}
