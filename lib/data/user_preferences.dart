import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _langKey = "language";

  static Future<void> deleteUserStorage() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      debugPrint('Success delete data user storage');
    }catch(e){
      debugPrint('Failed delete user storage: $e');
    }
  }

  static Future<int?> getIdUser() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getInt('userId');
      if (id != null){
        return id;
      }
      return null;
    }catch(e){
      debugPrint('Terjadi kesalahan pada getIdUser: $e');
      return null;
    }
  }

  static Future<void> setIdUser(int id) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', id);
    }catch(e){
      debugPrint('Terjadi kesalahan pada setIdUser: $e');
    }
  }

  // FUNCTION FOR STRING
  // SET
  static Future<void> setDataString({
    required String key,
    required String value,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
  // GET
  static Future<String> getDataString({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "Guest";
  }
  // DELETE
  static Future<void> deleteDataString({
    required String key,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // SERVICE FOR BOOLEAN
  // SET
  static Future<void> setDataBool({
    required String key,
    required bool value,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }
  // GET
  static Future<bool> getDataBool({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? true;
  }

  static Future<void> setDataLogin({
    required bool value,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', value);
  }
  // GET
  static Future<bool> getDataLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLogin') ?? false;
  }


  // SERVICE FOR LANGUAGE
  // GET
  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_langKey) ?? "en";
  }
  // SET
  static Future<void> saveLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, langCode);
  }

  // SERVICE FOR PROGRESS DAILY
  // GET
  static Future<int> getProgressDaily() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('progressDaily') ?? 0;
  }
  // SET
  static Future<void> setProgressDaily(int progress) async {
    final prefs = await SharedPreferences.getInstance();
    final progressOld = await getProgressDaily();
    final newProgress = progressOld + progress;
    await prefs.setInt('progressDaily', newProgress);
  }

  // SERVICE FOR DAILY
  static Future<void> checkDailyReset() async {
    final prefs = await SharedPreferences.getInstance();
    final lastReset = prefs.getString('lastResetDate');
    final today = DateTime.now();
    final todayString = "${today.year}-${today.month}-${today.day}";

    // first run handling
    if (lastReset == null) {
      await prefs.setString('lastResetDate', todayString);
      return;
    }
    if (todayString != lastReset) {
      await deleteDataString(key: 'progressDaily');
      await prefs.setString('lastResetDate', todayString);
    }
  }

}
