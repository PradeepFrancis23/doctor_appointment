import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

// ignore: must_be_immutable
class JsonOutput extends StatefulWidget {
  String day, timeslot;
  JsonOutput({super.key, required this.day, required this.timeslot});

  @override
  State<JsonOutput> createState() => _JsonOutputState();
}

class _JsonOutputState extends State<JsonOutput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Json Output'),
        ),
        body: Column(
          children: [
            Text(widget.day),
            const SizedBox(
              height: 10,
            ),
            Text(widget.timeslot),
          ],
        ));
  }
}
