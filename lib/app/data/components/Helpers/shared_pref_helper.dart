import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';
import '../../api_service/models/user_model.dart';



class SharedPref {
  //Keys
  static const String isLogin = 'isLogin';
  static const String token = 'token';
  static const String user = 'user';
  static const String uploadedImage = 'uploadedImage';
  static const String rewardCount = 'rewardCount';

  // For plain-text data
  Future<void> set(String key, dynamic value) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (value is bool) {
      sharedPreferences.setBool(key, value);
    } else if (value is String) {
      sharedPreferences.setString(key, value);
    } else if (value is double) {
      sharedPreferences.setDouble(key, value);
    } else if (value is int) {
      sharedPreferences.setInt(key, value);
    }
  }

  Future<bool> get(String key, {dynamic defaultValue}) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(key) ?? defaultValue;
  }

  Future<int> getInt(String key, {dynamic defaultValue}) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key) ?? defaultValue;
  }
  getData(String key, {dynamic defaultValue}) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(key) ?? defaultValue;
  }


  Future<void> setListOfString(String key, List<String> data) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList(key, data);
  }

  Future<List<String>> getListOfString(String key, {dynamic defaultValue}) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList(key) ?? [];
  }

  // For logging out
  static Future<void> deleteAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(isLogin).then((value) => Get.offAllNamed(Routes.LOGIN));
  }

  Future<void> setCurrentUser(UserModel model) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(user, jsonEncode(model.toJson()));
  }

  Future<UserModel?> get currentSavedUser async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString(user);
    if (data != null) {
      return UserModel.fromJson(jsonDecode(data));
    } else {
      return null;
    }
  }
}
