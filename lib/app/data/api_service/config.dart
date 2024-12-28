import 'package:flutter/cupertino.dart';
import '../../../main.dart';
import '../components/Helpers/shared_pref_helper.dart';
import 'api_provider.dart';
import 'models/user_model.dart';

BuildContext? homeContext;

class Config {
  // static String baseUrl = "https://backend.soulsage.app/api";
  static String baseUrl = "http://192.168.1.11:8000/admin";
// static String baseUrl = "http://13.202.253.214:80/api";
// static String baseUrl = "https://simplybaffled.com/api";
}

SharedPref sharedPref = sl<SharedPref>();
// APIProvider apiCall = sl<APIProvider>();
String? kToken;
UserModel? userModel;
