import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/auth/reset_password_screen.dart';
import 'package:task_manager_project_using_rest_api/ui/state_manager/otp_verification_controller.dart';
import '../../../widgets/screen_background.dart';
import 'login_screen.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String email;
  OtpVerificationScreen({super.key, required this.email});

  final TextEditingController _otpTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 65),
              Text(
                "PIN Verification",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 5),
              Text(
                "A 6 digit verification pin will send to your email address",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              PinCodeTextField(
                controller: _otpTEController,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  inactiveFillColor: Colors.white,
                  inactiveColor: Colors.red,
                  activeColor: Colors.white,
                  activeFillColor: Colors.white,
                  selectedColor: Colors.green,
                  selectedFillColor: Colors.white,
                ),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                cursorColor: Colors.green,
                onCompleted: (v) {},
                onChanged: (value) {},
                beforeTextPaste: (text) {
                  return true;
                },
                appContext: context,
              ),
              const SizedBox(height: 16),
              GetBuilder<OtpVerificationController>(
                builder: (otpVerificationController) {
                  return SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: otpVerificationController.otpVerificationInProgress == false,
                      replacement: const Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                        onPressed: () {
                          if(_otpTEController.text.length < 6){
                            Get.snackbar(
                              'Warning',
                              'Otp must be 6 digit!');
                          }
                          otpVerificationController.verifyOTP(email, _otpTEController.text).then((result){
                            if(result == true){
                              Get.snackbar(
                                'Success',
                                'Otp Verification success',
                              );
                              Get.to(() => ResetPasswordScreen(
                                email: email,
                                otp: _otpTEController.text,
                              ),);
                            }else{
                              Get.snackbar(
                                'Failed!',
                                'Otp Verification failed',
                              );
                            }
                          });
                        },
                        child: const Text("Verify"),
                      ),
                    ),
                  );
                }
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.offAll(() => const LoginScreen());
                    },
                    child: const Text("Sign in"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
