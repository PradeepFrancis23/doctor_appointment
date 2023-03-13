import 'package:doctor_appointment/authentication/auth_repo/authentication_repository.dart';
import 'package:doctor_appointment/screens/all_home_screens/main_home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LogInControllers {


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final RoundedLoadingButtonController loginbutnController =
      RoundedLoadingButtonController();

  var instancePhoneAuth = AuthenticationRepository();

  //  loginbtn
  void loginuser(context) async {
    // TODO context
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  address: '',
                  email: emailController.text,
                  fullname: '', password: '',
                )),
        (route) => false);
    // _sharedPreferences = await SharedPreferences.getInstance();
  }

  void phoneAuth(String phoneNo) {
    instancePhoneAuth.phoneAuthentication(phoneNo,context);
  }
}
