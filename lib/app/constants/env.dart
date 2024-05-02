import 'dart:convert';
import 'package:viswals/domain/models/user/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Env {
  static bool get debugMode {
    // return false;

    bool inDebugMode = false;
    assert(inDebugMode = true);

    return inDebugMode;
  }

  static String baseUrl = '';

  // ###### System Values
  static String appName = 'Viswals';
  static int connectionTimeout = 15;
  // ###### System Values

  // ###### Super Entities
  static User user = User();
  // ###### Super Entities

  // ###### User Storage
  static Future<void> setCachedUser(User user) async {
    Env.user = user;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString('user', userJson);
  }

  static Future<User?> getCachedUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');

    if (userJson == null) {
      return User();
    }

    final userMap = jsonDecode(userJson);
    return User.fromJson(userMap);
  }
  // ###### User Storage
}
