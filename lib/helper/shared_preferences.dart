import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future setBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, true);
  }

  static Future<bool> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

// static Future setListString(
// 	{required String id, required String token}) async {
// 	final prefs = await SharedPreferences.getInstance();
// 	prefs.setStringList(listSharedPreference, [id, token]);
// }

// static Future<List<String>> getListString() async {
// 	final prefs = await SharedPreferences.getInstance();
// 	return prefs.getStringList(listSharedPreference) ?? [];
// }

  static Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  static Future setString(String value, String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<void> removeString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static Future<bool> containsKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    bool containsKey = prefs.containsKey(key);
    return containsKey;
  }

  static Future setInt(int val, String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, val);
  }

  static Future<int> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  static Future setDouble(double val, String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(key, val);
  }

  static Future<double> getDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key) ?? 0.0;
  }

  static Future<void> setMap(String key, Map<String, dynamic> value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(value));
  }

  static Future<Map<String, dynamic>> getMap(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return jsonDecode(prefs.getString(key) ?? "") ?? {};
  }

  static Future clearSharedPref() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }

  static Future<void> storeTokenInPrefs(String token) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      // ignore: empty_catches
    } catch (e) {}
  }

  static Future<String?> getTokenFromPrefs() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // debugPrint('tokenInPrefs:${prefs.getString('token')}');
      return prefs.getString('token');
    } catch (e) {
      // debugPrint(e.toString());
      return e.toString();
    }
  }
}
