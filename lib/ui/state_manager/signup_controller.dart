import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class SignupController extends GetxController{
  bool _isSignUpInProgress = false;

  bool get isSignUpInProgress => _isSignUpInProgress;

  Future<bool> userSignUp(String email, String firstName, String lastName, String mobile, String password) async {
    _isSignUpInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": "",
    };

    final NetworkResponse response = await NetworkCaller().postRequest(
      Urls.registration,
      requestBody,
    );

    _isSignUpInProgress = false;
    update();

    if (response.isSuccess) {
      return true;
      /*

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registration Success"),
          ),
        );
      }*/
    } else {
      return false;
      /*if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registration fail!"),
          ),
        );
      }*/
    }
  }
}