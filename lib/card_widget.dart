import 'dart:convert';

import 'package:doctor_appointment/jsonoutput_screen.dart';
import 'package:doctor_appointment/models/doctors_model.dart';
import 'package:doctor_appointment/screens/appointment_status.dart';
import 'package:doctor_appointment/screens/doctors_list.dart';
import 'package:doctor_appointment/screens/doctors_profile.dart';
import 'package:doctor_appointment/services/users.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
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
  List<String> location = ['Mumbai', 'Chennai', 'Delhi', 'Ladakh', 'Pune'];
  List<String> degree = [
    'Mbbs - Surgeon',
    'Mbbs - Cardiologist',
    'Mbbs - Orthopedic',
    'Mbbs - Eye Specialist'
  ];

  int pageIndex = 0;

  final pages = [
    const DoctorsProfile(),
    const Doctorslist(),
    const AppointmentStatus(),
    const CardWidget(),
  ];
  late SharedPreferences sharedPreferences;

  ScrollController _controller = new ScrollController();

  void _goToElement(int index) {
    _controller.animateTo(
        (100.0 *
            (index +
                1)), // 100 is the height of container and index of 6th element is 5
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }

  int _selectedDayIndex = -1;
  int _selectedTimeIndex = -1;
  int selectValue = -1;
  static final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  String jsonstringmap = json.encode(days);

  static final List<String> timeSlot = [
    '8.30 to 9.30 am',
    '9.30 to 10.30 am',
    '10.30 to 11.30 am',
    '11.30 to 12.30 pm',
    '12.30 to 1pm Meeting',
    '1 to 1.30 Lunch',
    '2 to 3.30 pm',
  ];

  var _addCard = 7;
  // **increment fucnt
  void _incrementCard() {
    setState(() {
      _addCard++;
      selectdValue.add(items.toString());
    });
  }

  // decremnet fucti
  void _decrementCard(index) {
    setState(() {
      if (_addCard == 1) {
      } else {
        _addCard--;
      }
    });
  }

  // var _monday;
  final List<String> items = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  // **day selection list

  // selected value array
  List<String> selectdValue = [];
  static const String _drname = 'Dr Rupali Kumar';
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    // _addCard = 1;
    getSavedData();
  }

  void getSavedData() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Color wColor = Colors.white;
  Color bColor = Colors.black;

  Color pColor = const Color.fromARGB(255, 33, 243, 135);
  Color rColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Available Doctors')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: profilePic.length,
            itemBuilder: (BuildContext context, int index) {
              return card(profilePic[index], doctorname[index], degree[index],
                  location[index], context);
            }),
      ),
    );
  }

  Widget card(String image, String title, String degree, String location,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DoctorsProfile()));
        },
        child: Card(
            color: Colors.yellow[50],
            elevation: 8.0,
            margin: const EdgeInsets.all(4.0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  child: ClipOval(
                    child: Image.network(
                      image,
                      fit: BoxFit.fill,
                      matchTextDirection: true,

                      // height: MediaQuery.of(context).size.width * (3 / 4),
                      // width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 23.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        degree,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        location,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      //**Rating Start */
                    ],
                  ),
                )
              ],
            )
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.all(16.0),
            //       child: Image.network(
            //         image,
            //         // height: MediaQuery.of(context).size.width * (3 / 4),
            //         width: MediaQuery.of(context).size.width,
            //       ),
            //     ),
            //     Text(
            //       title,
            //       style: const TextStyle(
            //         fontSize: 38.0,
            //         fontWeight: FontWeight.w700,
            //       ),
            //     ),
            //     Text(
            //       degree,
            //       style: const TextStyle(
            //         fontSize: 27.0,
            //         fontWeight: FontWeight.w700,
            //       ),
            //     ),
            //     Text(
            //       location,
            //       style: const TextStyle(
            //         fontSize: 24.0,
            //         fontWeight: FontWeight.w700,
            //       ),
            //     ),
            //   ],
            // ),
            ),
      ),
    );
  }
  // Scaffold(
  //   bottomNavigationBar: Container(
  //     height: 60,
  //     decoration: BoxDecoration(
  //       color: Theme.of(context).primaryColor,
  //       borderRadius: const BorderRadius.only(
  //         topLeft: Radius.circular(20),
  //         topRight: Radius.circular(20),
  //       ),
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         IconButton(
  //           enableFeedback: false,
  //           onPressed: () {
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => const CardWidget()));
  //           },
  //           icon: const Icon(
  //             Icons.home_outlined,
  //             color: Colors.white,
  //             size: 35,
  //           ),
  //         ),
  //         IconButton(
  //           enableFeedback: false,
  //           onPressed: () {
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => const Doctorslist()));
  //           },
  //           icon: const Icon(
  //             Icons.work_outline_outlined,
  //             color: Colors.white,
  //             size: 35,
  //           ),
  //         ),
  //         IconButton(
  //           enableFeedback: false,
  //           onPressed: () {
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => const AppointmentStatus()));
  //           },
  //           icon: const Icon(
  //             Icons.widgets_outlined,
  //             color: Colors.white,
  //             size: 35,
  //           ),
  //         ),
  //         IconButton(
  //           enableFeedback: false,
  //           onPressed: () {
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => const DoctorsProfile()));
  //           },
  //           icon: const Icon(
  //             Icons.person_outline,
  //             color: Colors.white,
  //             size: 35,
  //           ),
  //         ),
  //       ],
  //     ),
  //   ),
  //   appBar: AppBar(
  //     title: const Text(
  //       "Find Your Specialist",
  //     ),
  //     actions: [
  //       IconButton(
  //         onPressed: () {
  //           // method to show the search bar
  //           showSearch(
  //               context: context,
  //               // delegate to customize the search bar
  //               delegate: CustomSearchDelegate());
  //         },
  //         icon: const Icon(Icons.search),
  //       ),
  //     ],
  //   ),
  //   body: Container(
  //     child: ListView.builder(
  //       scrollDirection: Axis.vertical,
  //       shrinkWrap: true,
  //       itemCount: _addCard,
  //       itemBuilder: (context, index) {
  //         return Column(
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(12.0),
  //               child: Container(
  //                 height: 300,
  //                 width: 450,
  //                 child: InkWell(
  //                   onLongPress: () {},
  //                   onTap: () {
  //                     // card press  open doct profile
  //                     Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                             builder: (context) => const DoctorsProfile()));
  //                   },
  //                   child: Card(
  //                     color: Colors.yellow[50],
  //                     elevation: 8.0,
  //                     margin: const EdgeInsets.all(4.0),
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(15)),
  //                     semanticContainer: true,
  //                     child: Column(
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.all(12.0),
  //                           child: Row(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               const CircleAvatar(
  //                                 radius: 60,
  //                                 backgroundImage:
  //                                     AssetImage('assets/images/doctor.jpg'),
  //                                 // backgroundImage: NetworkImage(
  //                                 //     "https://thumbs.dreamstime.com/b/female-doctor-avatar-character-icon-vector-illustration-design-177868552.jpg"),
  //                               ),
  //                               const SizedBox(
  //                                 width: 5,
  //                               ),

  //                               Column(
  //                                 crossAxisAlignment:
  //                                     CrossAxisAlignment.start,
  //                                 children: const [
  //                                   Text(
  //                                     _drname,
  //                                     style: TextStyle(
  //                                         fontSize: 22,
  //                                         fontWeight: FontWeight.bold),
  //                                   ),
  //                                   SizedBox(
  //                                     height: 7,
  //                                   ),
  //                                   Text(
  //                                     'Specialist: Eye/Skin',
  //                                     style: TextStyle(
  //                                         fontSize: 17,
  //                                         fontStyle: FontStyle.italic),
  //                                   ),
  //                                   SizedBox(
  //                                     height: 7,
  //                                   ),
  //                                   Text(
  //                                     'Rating: 5 Star',
  //                                     style: TextStyle(
  //                                         fontSize: 17,
  //                                         fontStyle: FontStyle.italic),
  //                                   ),
  //                                   SizedBox(
  //                                     height: 7,
  //                                   ),
  //                                   Text(
  //                                     'Address: Mumbai Matunga',
  //                                     style: TextStyle(
  //                                         fontSize: 17,
  //                                         fontStyle: FontStyle.italic),
  //                                   ),
  //                                 ],
  //                               ),

  //                               //  dd for day seletion
  //                             ],
  //                           ),
  //                           // timing for appointment
  //                         ),

  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //   ),
  // );
}
