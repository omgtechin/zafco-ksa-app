import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CacheClient {
  Future<int?> getInt(String key) async {
    return (await SharedPreferences.getInstance()).getInt(key);
  }

  Future<double?> getDouble(String key) async {
    return (await SharedPreferences.getInstance()).getDouble(key);
  }

  Future<bool?> getBool(String key) async {
    return (await SharedPreferences.getInstance()).getBool(key);
  }

  Future<String?> getString(String key) async {
    return (await SharedPreferences.getInstance()).getString(key);
  }

  Future<List<String>> getStringList(String key) async {
    return (await SharedPreferences.getInstance()).getStringList(key) ?? [];
  }

  Future<Map<String, dynamic>> getJsonObject(String key) async {
    final data = await getString(key) ?? "";
    return data != ''
        ? (jsonDecode(data) as Map<String, dynamic>)
        : <String, dynamic>{};
  }

  Future<List<dynamic>> getJsonArray(String key) async {
    final data = await getString(key);
    return data != null
        ? List<dynamic>.from(
            jsonDecode(data).map<String, dynamic>((dynamic e) => e).toList()
                as List<dynamic>,
          )
        : <dynamic>[];
  }

  Future<bool> putInt(String key, int value) async {
    return (await SharedPreferences.getInstance()).setInt(key, value);
  }

  Future<bool> putDouble(String key, double value) async {
    return (await SharedPreferences.getInstance()).setDouble(key, value);
  }

  Future putBool(String key, bool value) async {
    return (await SharedPreferences.getInstance()).setBool(key, value);
  }

  Future putString(String key, String value) async {
    return (await SharedPreferences.getInstance()).setString(key, value);
  }

  Future putStringList(String key, List<String> value) async {
    return (await SharedPreferences.getInstance()).setStringList(key, value);
  }

  Future putJsonObject(String key, Map<String, dynamic> json) async {
    return putString(key, jsonEncode(json));
  }

  Future putJsonArray(String key, List<dynamic> array) async {
    return putString(key, jsonEncode(array));
  }
}

class CashClientKey{
  static String loginId = "loginId";
  static String loginKey = "loginKey";
  static String language = "languageKey";
}

