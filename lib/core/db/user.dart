import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserCRUD {
  static Future<List<String>> addUser(
      {required Map<String, String> userData}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? userList = prefs.getStringList('users');
    List<String> insertedData = [];
    if (userList == null) {
      insertedData.add(json.encode(userData));
    } else {
      insertedData = userList..add(json.encode(userData));
    }
    await prefs.setStringList('users', insertedData);

    final newUserList = prefs.getStringList('users');
    return newUserList!;
  }

  static Future<List<String>?> getUsers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? userList = prefs.getStringList('users');
    return userList;
  }

  static Future<List<String>> removeUser({required int index}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? items = prefs.getStringList('users');
    items!.removeAt(index);
    await prefs.setStringList('users', items);

    final newUserList = prefs.getStringList('users');
    return newUserList!;
  }

  static Future<List<String>> updateUser(
      {required int index, required Map<String, String> newDataUser}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? items = prefs.getStringList('users');

    final oldUser = json.decode(items![index]);

    oldUser['nom'] = newDataUser['nom']!;
    oldUser['email'] = newDataUser['email']!;
    oldUser['password'] = newDataUser['password']!;

    items[index] = json.encode(oldUser);

    await prefs.setStringList('users', items);
    return items;
  }

  static Future<bool> isThisUserFound(
      {required Map<String, String> user}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? items = prefs.getStringList('users');
    if (items == null) {
      return false;
    }

    final test = items.where((element) {
      final olduser = json.decode(element);
      return olduser['email'] == user['email'] &&
          olduser['password'] == user['password'];
    }).toList();

    return test.isNotEmpty;
  }
}
