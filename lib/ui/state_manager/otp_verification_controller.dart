import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class OtpVerificationController extends GetxController{
  bool _otpVerificationInProgress = false;

  bool get otpVerificationInProgress => _otpVerificationInProgress;

  Future<bool> verifyOTP(String email, String otp) async {
    _otpVerificationInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.otpVerify(email, otp));

    _otpVerificationInProgress = true;
    update();

    if (response.isSuccess) {
      return true;
      /*if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPasswordScreen(
              email: widget.email,
              otp: _otpTEController.text,
            ),
          ),
        );
      }*/
    } else {
      return false;
      /*if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP verification has been failed!'),
          ),
        );
      }*/
    }
  }
}