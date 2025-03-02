import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setTheme(bool isDark) async {
    await sharedPreferences.setBool("isDark", isDark);
  }

  static bool getTheme() {
    return sharedPreferences.getBool("isDark") ?? false;
  }
}
