import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<void> setAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  Future<void> setUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_name", name);
  }

  Future<void> setUserEmail(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_email", name);
  }

  Future<bool> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return true;
  }
}
