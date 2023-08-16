import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class ResetPasswordController extends GetxController{
  bool _setPasswordInProgress = false;

  bool get setPasswordInProgress => _setPasswordInProgress;

  Future<bool> resetPassword(String email, String otp, String password) async {
    _setPasswordInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": otp,
      "password": password,
    };

    NetworkResponse response =
    await NetworkCaller().postRequest(Urls.resetPassword, requestBody);

    _setPasswordInProgress = false;
    update();

    if (response.isSuccess) {
      return true;
      /*if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
              (route) => false,
        );
      }*/
    } else {
      return false;
      /*if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reset password has been failed!'),
          ),
        );
      }*/
    }
  }
}