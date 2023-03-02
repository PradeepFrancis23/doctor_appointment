import 'package:doctor_appointment/card_widget.dart';

import 'package:flutter/material.dart';

class AppoinmentScreen extends StatefulWidget {
   
   AppoinmentScreen({super.key,});

  @override
  State<AppoinmentScreen> createState() => _AppoinmentScreenState();
}

class _AppoinmentScreenState extends State<AppoinmentScreen> {
   

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Doctors Appointment')),
      ),

      body: const CardWidget(),
     
    );
  }
}
