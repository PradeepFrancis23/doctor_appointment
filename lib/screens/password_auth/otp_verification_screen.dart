import 'package:doctor_appointment/authentication/auth_repo/authentication_repository.dart';
import 'package:doctor_appointment/authentication/controllers/otp_controller.dart';
import 'package:doctor_appointment/screens/password_auth/new_password.dart';
import 'package:doctor_appointment/widgets/otp_input.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({super.key});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  final controllers = OtpController();
  final instanceAuthRepo = AuthenticationRepository();

  String? _otp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Otp Verification"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Phone Number Verification'),
          const SizedBox(
            height: 30,
          ),
          // Implement 4 input fields
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OtpInput(controllers.fieldOne, true), // auto focus
              OtpInput(controllers.fieldTwo, false),
              OtpInput(controllers.fieldThree, false),
              OtpInput(controllers.fieldFour, false)
            ],
          ),
          const SizedBox(
            height: 30,
          ),

          RoundedLoadingButton(
              controller: controllers.submitOtp,
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const NewPasswordScreen()),
                    (route) => false);
                setState(() {
                  _otp = controllers.fieldOne.text +
                      controllers.fieldTwo.text +
                      controllers.fieldThree.text +
                      controllers.fieldFour.text;
                });
                instanceAuthRepo.verifyOtp(_otp.toString());
              },
              child: const Text("Submit Otp")),
          const SizedBox(
            height: 30,
          ),
          // Display the entered OTP code
          Text(
            _otp ?? 'Please enter OTP',
            style: const TextStyle(fontSize: 30),
          ),
          // ElevatedButton(
          //     onPressed: () {
          //       Navigator.of(context).pushAndRemoveUntil(
          //           MaterialPageRoute(
          //               builder: (context) => const NewPasswordScreen()),
          //           (route) => false);
          //       setState(() {
          //         _otp = controllers.fieldOne.text +
          //             controllers.fieldTwo.text +
          //             controllers.fieldThree.text +
          //             controllers.fieldFour.text;
          //       });
          //     },
          //     child: const Text('Submit')),
          // const SizedBox(
          //   height: 30,
          // ),
          // // Display the entered OTP code
          // Text(
          //   _otp ?? 'Please enter OTP',
          //   style: const TextStyle(fontSize: 30),
          // )
        ],
      ),
    );
  }
}
