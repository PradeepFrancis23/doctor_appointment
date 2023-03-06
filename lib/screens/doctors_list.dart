import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Doctorslist extends StatefulWidget {
  const Doctorslist({super.key});

  @override
  State<Doctorslist> createState() => _DoctorslistState();
}

class _DoctorslistState extends State<Doctorslist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor List'),
      ),
    );
  }
}
