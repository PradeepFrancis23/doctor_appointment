import 'dart:async';

import 'package:doctor_appointment/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: const Padding(
              padding: EdgeInsets.all(50.0),
              child: Image(
                  image: AssetImage(
                'assets/images/splash_image.jpg',
              )),
            ),

            // const Image(image: AssetImage('assets/images/homepage_image.jpg'))
          ),
          Text('data'),
        ],
      ),
    );
  }
}
