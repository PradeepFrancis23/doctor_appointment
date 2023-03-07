import 'package:doctor_appointment/appointment_day_select_screen.dart';
import 'package:doctor_appointment/card_widget.dart';

import 'package:doctor_appointment/screens/appointment_status.dart';
import 'package:doctor_appointment/screens/doctors_profile.dart';
import 'package:doctor_appointment/screens/home_login_signup.dart';
import 'package:doctor_appointment/screens/login_screen.dart';
import 'package:doctor_appointment/screens/main_home_screen.dart';
import 'package:doctor_appointment/screens/signup_screen.dart';
import 'package:doctor_appointment/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      home: const SignupScreen(),
    );
  }
}
