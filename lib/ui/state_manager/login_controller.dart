import 'package:get/get.dart';

import '../../data/models/auth_utility.dart';
import '../../data/models/login_model.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class LoginController extends GetxController{
  bool _isLoginProgress = false;
  bool get isLoginProgress => _isLoginProgress;

  Future<bool> userLogin(String email, String password) async {
    _isLoginProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };

    final NetworkResponse response = await NetworkCaller()
        .postRequest(Urls.login, requestBody, isLogin: true);

    _isLoginProgress = false;
    update();

    if (response.isSuccess) {
      await AuthUtility.saveUserInfo(LoginModel.fromJson(response.body!));
      return true;
    } else {
      return false;
      /*if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Incorrect email or password"),
          ),
        );
      }*/
    }
  }
}