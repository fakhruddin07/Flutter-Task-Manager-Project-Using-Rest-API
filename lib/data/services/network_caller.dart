import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager_project_using_rest_api/app.dart';
import 'package:task_manager_project_using_rest_api/data/models/auth_utility.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/auth/login_screen.dart';
import '../models/network_response.dart';

class NetworkCaller {
  Future<NetworkResponse> getRequest(String url) async {
    try {
      Response response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else {
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return const NetworkResponse(false, -1, null);
  }

  Future<NetworkResponse> postRequest(
      String url, Map<String, dynamic> body) async {
    try {
      Response response = await post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "token": AuthUtility.userInfo.token.toString(),
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        gotoLogin();
      } else {
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return const NetworkResponse(false, -1, null);
  }

  gotoLogin() async {
    await AuthUtility.clearUserInfo();
    Navigator.pushAndRemoveUntil(
        TaskManagerApp.globalKey.currentState!.context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false);
  }
}
