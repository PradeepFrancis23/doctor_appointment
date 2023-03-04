import 'package:doctor_appointment/appointment_day_select_screen.dart';
import 'package:doctor_appointment/new_card_screen.dart';
import 'package:doctor_appointment/screens/home_login_signup.dart';
import 'package:doctor_appointment/screens/login_screen.dart';
import 'package:doctor_appointment/screens/signup_screen.dart';
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
      ),
      home: const LoginScreen(),
    );
  }
}
