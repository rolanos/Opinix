import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static Future<void> clear() async {
    final instance = await SharedPreferences.getInstance();
    instance.clear();
  }

  static Future<bool> setUserId(String userId) async {
    final instance = await SharedPreferences.getInstance();
    return await instance.setString('userId', userId);
  }

  static Future<String?> getUserId() async {
    final instance = await SharedPreferences.getInstance();
    return instance.getString('userId');
  }

  static Future<bool> setAccessToken(String token) async {
    final instance = await SharedPreferences.getInstance();
    return await instance.setString('access-token', token);
  }

  static Future<bool> setRefreshToken(String token) async {
    final instance = await SharedPreferences.getInstance();
    return await instance.setString('refresh-token', token);
  }

  static Future<bool> setAnonymous() async {
    final instance = await SharedPreferences.getInstance();
    return instance.setBool('anonymous', true);
  }

  static Future<bool> getAnonymous() async {
    final instance = await SharedPreferences.getInstance();
    return instance.getBool('anonymous') ?? false;
  }

  static Future<String?> getAccessToken() async {
    final instance = await SharedPreferences.getInstance();
    return instance.getString('access-token');
  }

  static Future<String?> getRefreshToken() async {
    final instance = await SharedPreferences.getInstance();
    return instance.getString('refresh-token');
  }

  static Future<Map<String, dynamic>> getTokenAsMap() async {
    final instance = await SharedPreferences.getInstance();
    final token = instance.getString('access-token');
    return {'Authorization': 'Bearer $token'};
  }
}
