import 'package:doctor_appointment/card_widget.dart';

import 'package:flutter/material.dart';

class AppoinmentScreen extends StatefulWidget {
  const AppoinmentScreen({super.key});

  @override
  State<AppoinmentScreen> createState() => _AppoinmentScreenState();
}

class _AppoinmentScreenState extends State<AppoinmentScreen> {
  var _addCard = 3;
  // **increment fucnt
  void _incrementCard() {
    setState(() {
      _addCard++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Doctors Appointment')),
      ),

      body: const CardWidget(),
      // ListView.builder(
      //     itemCount: _addCard,
      //     itemBuilder: (context, index) => const NewCardWidget()),
    );
  }
}
