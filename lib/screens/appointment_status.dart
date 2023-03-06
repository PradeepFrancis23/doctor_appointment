import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentStatus extends StatefulWidget {
  const AppointmentStatus({super.key});

  @override
  State<AppointmentStatus> createState() => _AppointmentStatusState();
}

class _AppointmentStatusState extends State<AppointmentStatus> {
  // ** Dif doctor profile pic
  List<String> profilePic = [
    'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg',
    'https://expertphotography.b-cdn.net/wp-content/uploads/2020/08/profile-photos-4.jpg',
    'https://sb.kaleidousercontent.com/67418/960x550/12beafc181/individuals-1.png',
    'https://d1r8m46oob3o9u.cloudfront.net/images/home-page-examples/04.jpg',
  ];

  // **Dr name
  List<String> doctorname = [
    'Dr Rithika Shah',
    'Dr Kumar Vishwas',
    'Dr Suresh K',
    'Dr Rupali Shah'
  ];
  // **DAte and time
  List<String> appotmDatetime = [
    '16 Nov Monday 10:30am',
    '17 Nov Tuesday 11:30am',
    '18 Nov Wednesday 8:30am',
    '19 Nov Thursday 10:00am',
    '20 Nov Friday 9:30am'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('My Appoitnments')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: profilePic.length,
            itemBuilder: (BuildContext context, int index) {
              return card(profilePic[index], doctorname[index], context);
            }),
      ),
    );
  }

  Widget card(String image, String title, BuildContext context) {
    return Card(
      color: Colors.yellow[50],
      elevation: 8.0,
      margin: const EdgeInsets.all(4.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.network(
              image,
              height: MediaQuery.of(context).size.width * (3 / 4),
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 38.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
