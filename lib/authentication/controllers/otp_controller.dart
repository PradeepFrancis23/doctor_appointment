import 'package:doctor_appointment/authentication/auth_repo/authentication_repository.dart';
import 'package:doctor_appointment/screens/auth_screens/login_bloc/login_bloc.dart';
import 'package:doctor_appointment/screens/auth_screens/login_screen.dart';
import 'package:doctor_appointment/screens/password_auth/otp_verification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:path/path.dart' as path;


class OtpController {
  final TextEditingController fieldOne = TextEditingController();
  final TextEditingController fieldTwo = TextEditingController();
  final TextEditingController fieldThree = TextEditingController();
  final TextEditingController fieldFour = TextEditingController();
  final RoundedLoadingButtonController submitOtp =
      RoundedLoadingButtonController();

  final instanceAuthRepo = AuthenticationRepository();

  void verifyOtp(String otp) async {
        // TODO context
    var isVerified = await instanceAuthRepo.verifyOtp(otp);
    // isVerified
    //     ? Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) => BlocProvider(
    //                   create: (context) => LoginBloc(),
    //                   child: const LoginScreen(
    //                     address: '',
    //                     email: '',
    //                     fullname: '',
    //                     password: '',
    //                   ),
    //                 )),
    //       )
    //     : Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => const OTPVerification(),
    //         ),
    //       );
  }
}
