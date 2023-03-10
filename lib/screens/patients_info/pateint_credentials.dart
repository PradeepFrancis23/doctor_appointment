import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:doctor_appointment/screens/appointments_status_check/appointment_day_select_screen.dart';
import 'package:doctor_appointment/screens/auth_screens/login_bloc/login_bloc.dart';

import 'package:doctor_appointment/screens/auth_screens/login_screen.dart';
import 'package:doctor_appointment/screens/doctors_info_screens/doctors_list.dart';
import 'package:doctor_appointment/screens/doctors_info_screens/doctors_profile.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientCredentials extends StatefulWidget {
  final String email;

  const PatientCredentials({super.key, required this.email});

  @override
  State<PatientCredentials> createState() => _PatientCredentialsState();
}

class _PatientCredentialsState extends State<PatientCredentials> {
  String token = "";

  bool isDarkModeEnabled = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPateintsCred();
  }

  getPateintsCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("login")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          DayNightSwitcher(
            isDarkModeEnabled: isDarkModeEnabled,
            onStateChanged: onStateChanged,
          ),
        ],
        backgroundColor: Colors.transparent,
        title: Center(child: const Text('Clinic name')),
      ),
      drawer: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(2), bottomRight: Radius.circular(190.0)),
        child: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: [
                const DrawerHeader(
                  // decoration: BoxDecoration(
                  //   color: Colors.green,
                  // ), //BoxDecoration
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Colors.transparent),
                    accountName: Text(
                      "Clinic Name",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    accountEmail: Text(
                      "abhishekm977@gmail.com",
                      style: TextStyle(color: Colors.black),
                    ),
                    currentAccountPictureSize: Size.square(50),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 165, 255, 137),
                      child: Text(
                        // **logo
                        "A",
                        style: TextStyle(fontSize: 30.0, color: Colors.blue),
                      ), //Text
                    ), //circleAvatar
                  ), //UserAccountDrawerHeader
                ), //DrawerHeader
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text(' My Doctor '),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Doctorslist()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.book),
                  title: const Text(' My Appoitnments '),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppoinmentScreen()));
                    // Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.workspace_premium),
                  title: const Text(' Specialist Doctor '),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorsProfile()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.video_label),
                  title: const Text(' Address map '),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text(' Contact Info '),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    await pref.clear();
                    Duration(milliseconds: 1500);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logged out')));

                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => LoginBloc(),
                                  child: LoginScreen(address: '', email: '', fullname: '', password: '',),
                                )),
                        (route) => false);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text("Your Email is :  ${widget.email}"),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: Text('Your token is  : $token'),
            ),
          ],
        ),
      ),
    );
  }

  onStateChanged(bool isDarkModeEnabled) {
    setState(() {
      this.isDarkModeEnabled = isDarkModeEnabled;
    });
  }
}
