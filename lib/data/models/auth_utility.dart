import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_project_using_rest_api/data/models/login_model.dart';
class AuthUtility{
  AuthUtility._();

  static LoginModel userInfo = LoginModel();

  static Future<void> saveUserInfo(LoginModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_data", jsonEncode(model.toJson()));
    userInfo = model;
  }

  static Future<LoginModel> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
     String userData = prefs.getString("user_data")!;
     return LoginModel.fromJson(jsonDecode(userData));
  }

  static Future<void> clearUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<bool> checkIfUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogIn = prefs.containsKey("user_data");
    if(isLogIn){
      userInfo = await getUserInfo();
    }
    return isLogIn;
  }
}