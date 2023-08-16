import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class EmailVerificationController extends GetxController{
  bool _emailVerificationInProgress = false;

  bool get emailVerificationInProgress => _emailVerificationInProgress;

  Future<bool> sendOtpToEmail(String email) async {
    _emailVerificationInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller().getRequest(
      Urls.sendOtpToEmail(email),
    );

    _emailVerificationInProgress = false;
    update();

    if (response.isSuccess) {
      return true;
      /*if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerificationScreen(
              email: _emailTEController.text.trim(),
            ),
          ),
        );
      }*/
    } else {
      return false;
      /*if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email verification has been failed!'),
          ),
        );
      }*/
    }
  }
}