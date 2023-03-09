
import 'package:doctor_appointment/screens/password_auth/new_password.dart';
import 'package:doctor_appointment/widgets/otp_input.dart';
import 'package:flutter/material.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({super.key});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  // 4 text editing controllers that associate with the 4 input fields
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController(); 

   // This is the entered code
  // It will be displayed in a Text widget
  String? _otp;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text("Otp Verification"),),
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
              OtpInput(_fieldOne, true), // auto focus
              OtpInput(_fieldTwo, false),
              OtpInput(_fieldThree, false),
              OtpInput(_fieldFour, false)
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                 Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => const NewPasswordScreen(
                 
                )),
        (route) => false);
                setState(() {
                  _otp = _fieldOne.text +
                      _fieldTwo.text +
                      _fieldThree.text +
                      _fieldFour.text;
                });
              },
              child: const Text('Submit')),
          const SizedBox(
            height: 30,
          ),
          // Display the entered OTP code
          Text(
            _otp ?? 'Please enter OTP',
            style: const TextStyle(fontSize: 30),
          )
        ],
      ),
    );
    
  }
}