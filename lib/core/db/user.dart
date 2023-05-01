import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserCRUD {
  static Future<void> addUser({required Map<String, String> userData}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? userList = prefs.getStringList('users');
    List<String> insertedData = [];
    if (userList == null) {
      insertedData.add(json.encode(userData));
    } else {
      insertedData = userList..add(json.encode(userData));
    }
    await prefs.setStringList('users', insertedData);
  }

  static Future<List<String>?> getUsers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? userList = prefs.getStringList('users');
    return userList;
  }
}
