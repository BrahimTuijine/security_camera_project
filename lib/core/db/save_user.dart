import 'dart:convert';

import 'package:security_camera_project/core/Model/saved_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalUser {
  static Future<void> saveUserInLoacal(SavedUser user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('user', json.encode(user.toJson()));
  }

  static Future<SavedUser?> isUserFromLocalFound() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? user = prefs.getString('user');

    if (user != null) {
      return SavedUser.fromJson(json.decode(user));
    } else {
      return null;
    }
  }

  static Future<void> deleteUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }
}
