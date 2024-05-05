import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:viswals/app/constants/env.dart';
import 'package:viswals/app/helpers/api/api_helper.dart';
import 'package:viswals/app/helpers/debugger_helper.dart';
import 'package:viswals/domain/models/user/user_model.dart';

import 'package:viswals/domain/providers/user/user_dependencies.dart';

class UserLocalProvider implements UserProviderProtocol {
  @override
  Future<ApiResponse> setUser(User newUser) async {
    try {
      final success = await setCachedUser(newUser);

      ApiResponse response = ApiResponse(
        success: success,
        object: newUser,
      );
      return response;
    } catch (e) {
      Log.e('[provider]', error: e);
      rethrow;
    }
  }

  @override
  Future<ApiResponse> getUser() async {
    try {
      final user = await getCachedUser();
      final success = user != null;

      ApiResponse response = ApiResponse(
        success: success,
        object: user,
      );
      return response;
    } catch (e) {
      Log.e('[provider]', error: e);
      rethrow;
    }
  }

  Future<bool> setCachedUser(User user) async {
    try {
      Env.user = user;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userJson = jsonEncode(user.toJson());
      await prefs.setString('user', userJson);
      return true;
    } catch (e) {
      Log.e("Error on set user cache", error: e);
      return false;
    }
  }

  Future<User?> getCachedUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user');

      if (userJson == null) {
        return User();
      }

      final userMap = jsonDecode(userJson);
      return User.fromJson(userMap);
    } catch (e) {
      Log.e("Error on get cached user", error: e);
      return null;
    }
  }
}
