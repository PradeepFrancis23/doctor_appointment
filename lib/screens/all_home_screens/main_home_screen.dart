import 'package:day_night_switcher/day_night_switcher.dart';

import 'package:doctor_appointment/models/doctors_model.dart';
import 'package:doctor_appointment/screens/appointments_status_check/appointment_day_select_screen.dart';
import 'package:doctor_appointment/screens/auth_screens/login_bloc/login_bloc.dart';
import 'package:doctor_appointment/screens/auth_screens/login_screen.dart';
import 'package:doctor_appointment/screens/doctors_info_screens/doctors_list.dart';
import 'package:doctor_appointment/screens/doctors_info_screens/doctors_profile.dart';
import 'package:doctor_appointment/widgets/card_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  final String email;
  final String fullname;
  final String address;
  const HomeScreen(
      {super.key,
      required this.email,
      required this.fullname,
      required this.address});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    darkTheme:
    ThemeData.dark().copyWith(
      appBarTheme: AppBarTheme(color: const Color(0xFF253341)),
      scaffoldBackgroundColor: const Color(0xFF15202B),
    );
    themeMode:
    isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light;
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
                DrawerHeader(
                  // decoration: BoxDecoration(
                  //   color: Colors.green,
                  // ), //BoxDecoration
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Colors.transparent),
                    accountName: Text(
                      widget.fullname,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    accountEmail: Text(
                      widget.email,
                      style: TextStyle(color: Colors.black),
                    ),

                    currentAccountPictureSize: Size.square(50),
                    currentAccountPicture: const CircleAvatar(
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
                  title: const Text('LogOut'),
                  onTap: () {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: widget.email, password: '')
                        .then((value) async {
                      print("logged out");

                      // SharedPreferences pref =
                      //     await SharedPreferences.getInstance();
                      // await pref.clear();
                      const Duration(milliseconds: 1500);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Logged out')));

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                    create: (context) => LoginBloc(),
                                    child: const LoginScreen(
                                      address: '',
                                      email: '',
                                      fullname: '',
                                      password: '',
                                    ),
                                  )),
                          (route) => false);
                    }).onError((error, stackTrace) {
                      print("${error.toString()}");
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // doctor photo

            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                  child: Image(
                      image: AssetImage('assets/images/doctor_search.jpg'))),
            ),
            const Text(
              'Serach Your Specialist !!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // **Serach Area
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(width: 0.8)),
                    hintText: 'Select Your Area',
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 30.0,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.home,
                        ))),
              ),
            ),
            // **Serach Doctor
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(width: 0.8)),
                    hintText: 'Search Specialist Doctor',
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 30.0,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.medication,
                        ))),
              ),
            ),
            // ** select date
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(width: 0.8)),
                    hintText: 'Select Date',
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 30.0,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.date_range,
                        ))),
              ),
            ),
            //** */ SErach btn
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                // ignore: prefer_const_constructors
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  minimumSize: const Size.fromHeight(50), // NEW
                ),

                onPressed: () {
                  // **show Doctors list
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CardWidget()));
                },
                child: const Text('Search'),
              ),
            ),
          ],
        ),
      ),

      // Container(

      //   child: Center(
      //     child: IconButton(
      //       onPressed: () {
      //         // method to show the search bar
      //         showSearch(
      //             context: context,
      //             // delegate to customize the search bar
      //             delegate: CustomSearchDelegate());
      //       },
      //       icon: const Icon(Icons.search),
      //     ),
      //   ),
      // ),
    );
  }

  onStateChanged(bool isDarkModeEnabled) {
    setState(() {
      this.isDarkModeEnabled = isDarkModeEnabled;
    });
  }
}
