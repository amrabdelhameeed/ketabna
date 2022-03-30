import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBool(
      {required String key, required bool value}) async {
    init();
    return await sharedPreferences!.setBool(key, value);
  }

  static bool getBool({required String key}) {
    init();
    return sharedPreferences!.getBool(key)!;
  }

  static Future<bool> putStr(
      {required String key, required String value}) async {
    init();
    return await sharedPreferences!.setString(key, value);
  }

  static String getStr({required String key}) {
    init();
    return sharedPreferences!.getString(key) ?? "";
  }

  static Future<bool> deleteSharedPref() {
    return sharedPreferences!.clear();
  }
}
