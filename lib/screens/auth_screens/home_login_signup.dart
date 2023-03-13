import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:doctor_appointment/screens/auth_screens/login_bloc/login_bloc.dart';
import 'package:doctor_appointment/screens/auth_screens/login_screen.dart';
import 'package:doctor_appointment/screens/auth_screens/signup_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Home extends StatelessWidget {
    // bool isDarkModeEnabled = false;
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    RoundedLoadingButtonController loginbtnController =
        RoundedLoadingButtonController();
    RoundedLoadingButtonController signupController =
        RoundedLoadingButtonController();
    return Scaffold(
      // appBar: AppBar(
      //    actions: [
      //     DayNightSwitcher(
      //       isDarkModeEnabled: isDarkModeEnabled,
      //       onStateChanged: onStateChanged,
      //     ),
      //    ],
      // ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Hello There!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Automatic identity verification which enable you to verify your identity",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[700], fontSize: 15),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        child: const Image(
                            image:
                                AssetImage('assets/images/homepage_image.jpg')),
                      ),
                      // **login btn
                      const SizedBox(
                        height: 200,
                      ),
                      // login btn
                      RoundedLoadingButton(
                          color: Colors.indigoAccent[400],
                          controller: loginbtnController,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) => LoginBloc(),
                                        child: const LoginScreen(address: '', email: '', fullname: '', password: '',),
                                      )),
                            );
                            loginbtnController.reset();
                          },
                          child: const Text('Login')),
                      // MaterialButton(
                      //   minWidth: double.infinity,
                      //   height: 60,
                      //   onPressed: () {},
                      //   shape: RoundedRectangleBorder(
                      //       side: const BorderSide(
                      //         color: Colors.black,
                      //       ),
                      //       borderRadius: BorderRadius.circular(40)),
                      //   child: const Text(
                      //     "Login",
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.w600,
                      //         fontSize: 16,
                      //         color: Colors.white70),
                      //   ),
                      // ),
                      // **Signup btn
                      const SizedBox(
                        height: 15,
                      ),
                      RoundedLoadingButton(
                          color: Colors.redAccent,
                          controller: signupController,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupScreen()),
                            );
                            signupController.reset();
                          },
                          child: const Text('Signup')),
                      // MaterialButton(
                      //   minWidth: double.infinity,
                      //   height: 60,
                      //   onPressed: () {},
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(40)),
                      //   child: const Text(
                      //     "Sign UP",
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.w600,
                      //       fontSize: 16,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  // onStateChanged(bool isDarkModeEnabled) {
    
  //     this.isDarkModeEnabled = isDarkModeEnabled;
  
  // }
}
