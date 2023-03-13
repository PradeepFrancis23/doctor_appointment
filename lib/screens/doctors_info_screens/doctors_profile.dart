import 'dart:convert';



import 'package:doctor_appointment/screens/all_home_screens/main_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:path/path.dart';

class DoctorsProfile extends StatefulWidget {
  const DoctorsProfile({super.key});

  @override
  State<DoctorsProfile> createState() => _DoctorsProfileState();
}

class _DoctorsProfileState extends State<DoctorsProfile> {
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
  var theme1 = Colors.white;
  var theme2 = Color(0xff2E324F);
  var white = Colors.white;
  var black = Colors.black;
  Color wColor = Colors.white;
  Color bColor = Colors.black;

  Color pColor = const Color.fromARGB(255, 33, 243, 135);
  Color rColor = Colors.red;

  bool switchColor = false;
  String _patients = 'Patients';
  String _experience = 'Experience';
  String _review = 'Review';
  String patientsCount = '900 +';
  String exeperinceyear = '8 years';
  String reviewcount = '200 +';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme1,
      appBar: AppBar(
        backgroundColor: theme1,
        elevation: 0.0,
        leading: Icon(
          Icons.arrow_back,
          color: black,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.favorite_border,
              color: black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 12.0, 8.0),
            child: Icon(
              Icons.more_vert,
              color: black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _profilePic(),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
              child: Text("Taylor Watson",
                  style: TextStyle(
                      color: black,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold)),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
              child: Text(
                "PRODUCT DESIGNER",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text("Create great interfaces",
                style: TextStyle(
                    color: black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal)),
            Text("@TwWorks",
                style: TextStyle(
                    color: black,
                    decoration: TextDecoration.underline,
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal)),
            _networkingLinks(),
            _hireButton(),
            const Padding(
              padding: EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 0.0),
              child: Divider(
                color: Color(0xff78909c),
                height: 50.0,
              ),
            ),
            _followers(),
            const SizedBox(
              height: 10,
            ),
            Divider(),
            // **day slot
            Text(
              'Select Available Slots  ',
              style: TextStyle(
                  fontSize: 16,
                  color: bColor.withOpacity(0.6),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (index == 0) {
                            selectValue = index + 1;
                          } else if (index == 1) {
                            selectValue = index + 3;
                          } else {
                            selectValue = index;
                          }

                          // ignore: unrelated_type_equality_checks
                          _selectedDayIndex = index;
                          _goToElement(selectValue);
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        decoration: BoxDecoration(
                          color: index == _selectedDayIndex
                              ? pColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 61, 59, 59),
                              blurRadius: 4,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              days[index],
                              style: const TextStyle(
                                  // color: index == 1
                                  //     ? wColor
                                  //     : bColor.withOpacity(0.6),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),

            const SizedBox(
              height: 10,
            ),

            // **Time Booking Slot
            Container(
              height: 50,
              child: ListView.builder(
                  shrinkWrap: true,
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedTimeIndex = index;
                          selectValue = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        decoration: BoxDecoration(
                          color: index == selectValue ? pColor : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 61, 59, 59),
                              blurRadius: 4,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              timeSlot[index],
                              style: const TextStyle(
                                  // color: index == 1
                                  //     ? wColor
                                  //     : bColor.withOpacity(0.6),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            //
            // **time slot
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                // ignore: prefer_const_constructors
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  minimumSize: const Size.fromHeight(50), // NEW
                ),

                onPressed: () {
                  // **show Doctors list
                  // book appointment show days availbe slot etc screen then confirm booking butn then show bookinh confirm dailog then home then in apptnm status show list of appointment booked
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>   HomeScreen(address: '', email: '', fullname: '', password: '',)));
                },
                child: const Text('Confirm Appointment'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _followers() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _followerDetails(
              "assets/images/patientsCount.png", _patients, patientsCount),
          _followerDetails(
              "assets/images/exp.png", _experience, exeperinceyear),
          _followerDetails("assets/images/review.jpg", _review, reviewcount),
        ],
      );

  Column _followerDetails(String image, String text, String description) =>
      Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(45.0, 16.0, 40.0, 16.0),
            child: Container(
              width: 50.0,
              height: 50.0,
              child: Image.asset(
                image,
              ),
            ),
          ),
          Text(description,
              style: TextStyle(
                  color: black, fontWeight: FontWeight.bold, fontSize: 20.0)),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(text,
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0)),
          ),
        ],
      );

  _hireButton() => ElevatedButton(
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        onPressed: () {
          // small dialof showingg contact info

          openContactinfoDailog(this.context);

          // setState(() {
          //   if (switchColor == false) {
          //     black = Colors.white;
          //     white = Colors.black;
          //     theme1 = Color(0xff2E324F);
          //     switchColor = true;
          //   } else {
          //     black = Colors.black;
          //     white = Colors.white;
          //     theme1 = Colors.white;
          //     switchColor = false;
          //   }
          // });
        },
        // height: 40.0,
        // minWidth: 140.0,

        child: const Text(
          "Contact Info",
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      );

  Row _networkingLinks() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _networkIcon("assets/images/linkedin.png.png"),
          _networkIcon("assets/images/insta.png"),
          _networkIcon("assets/images/fb.png"),
          _networkIcon("assets/images/tweet.png")
        ],
      );

  Padding _networkIcon(String image) => Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 15.0),
        child: Container(height: 25.0, width: 25.0, child: Image.asset(image)),
      );

  Container _profilePic() => Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 15.0),
          child: Stack(
            alignment: const Alignment(0.9, 0.9),
            children: const <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/doctor.jpg'),
                radius: 70.0,
              ),
              // **verified tick
              // Container(
              //   height: 30.0,
              //   width: 30.0,
              //   child: Image.asset("assets/images/verified.jpg"),
              //   alignment: Alignment.bottomRight,
              // ),
            ],
          ),
        ),
      );
}

Future openContactinfoDailog(BuildContext context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
          title: const Text('Contact Information'),
          content: Column(
            children: const [
              Text(
                'Phone Number : 84651122548,',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Email: ajhfa@gmail.com',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Emergency message: 788888',
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
        ));
