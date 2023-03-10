import 'dart:async';

import 'package:doctor_appointment/screens/auth_screens/home_login_signup.dart';
import 'package:doctor_appointment/screens/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
          child: Center(
            child: Text(
              ' Step3 klinic ',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 239, 243, 245),
                    letterSpacing: .5),
              ),
            ),
          ),
        ));
  }
}
