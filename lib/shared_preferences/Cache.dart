import 'package:shared_preferences/shared_preferences.dart';

class CasheHelper
{

  static late SharedPreferences prefs;

  static init() async
  {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({
    required key,
    required value
  }) async
  {
    return await prefs.setBool(key, value);
  }

  static bool? getData({
    required key,
  })
  {
    return prefs.getBool(key);
  }

}