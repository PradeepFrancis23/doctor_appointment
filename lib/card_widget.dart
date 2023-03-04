import 'dart:convert';

import 'package:doctor_appointment/jsonoutput_screen.dart';
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

  var _addCard = 0;
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
    _addCard = 1;
    getSavedData();
  }

  void getSavedData() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // void storeDAta() {
  //   Users users = Users(
  //       _drname, _selectedDayIndex.toString(), _selectedTimeIndex.toString());

  //   // covert into json formar
  //   String userdata = jsonDecode(users.toString());
  //   print(userdata);

  //   sharedPreferences.setString('userData', userdata);
  // }

  // List<Icon> catIcons = [Icons()];

  Color wColor = Colors.white;
  Color bColor = Colors.black;

  Color pColor = const Color.fromARGB(255, 33, 243, 135);
  Color rColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: ListView.builder(
            itemCount: _addCard,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 320,
                        width: 450,
                        child: Card(
                          semanticContainer: true,
                          shape: const RoundedRectangleBorder(
                            //<-- SEE HERE
                            side: BorderSide(
                              color: Colors.greenAccent,
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CircleAvatar(
                                      radius: 40,
                                      backgroundImage: AssetImage(
                                          'assets/images/doctor.jpg'),
                                      // backgroundImage: NetworkImage(
                                      //     "https://thumbs.dreamstime.com/b/female-doctor-avatar-character-icon-vector-illustration-design-177868552.jpg"),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),

                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(_drname),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text('Specialist: Eye/Skin'),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text('Rating: 5 Star'),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text('Address: Mumbai Matunga'),
                                      ],
                                    ),

                                    //  dd for day seletion
                                    // DropdownButtonHideUnderline(
                                    //   child: DropdownButton2(
                                    //     isExpanded: true,
                                    //     hint: Row(
                                    //       children: const [
                                    //         Icon(
                                    //           Icons.list,
                                    //           size: 16,
                                    //           color: Colors.yellow,
                                    //         ),
                                    //         SizedBox(
                                    //           width: 4,
                                    //         ),
                                    //         Text(
                                    //           'Select Day',
                                    //           style: TextStyle(
                                    //             fontSize: 14,
                                    //             fontWeight: FontWeight.bold,
                                    //             color: Colors.yellow,
                                    //           ),
                                    //           overflow: TextOverflow.ellipsis,
                                    //         ),
                                    //       ],
                                    //     ),
                                    //     items: items
                                    //         .map((item) => DropdownMenuItem<String>(
                                    //               value: item,
                                    //               child: Text(
                                    //                 item,
                                    //                 style: const TextStyle(
                                    //                   fontSize: 14,
                                    //                   fontWeight: FontWeight.bold,
                                    //                   color: Colors.white,
                                    //                 ),
                                    //                 overflow: TextOverflow.ellipsis,
                                    //               ),
                                    //             ))
                                    //         .toList(),
                                    //     value: selectedValue,
                                    //     onChanged: (value) {
                                    //       //  if(selectedValue == 'Monday'){

                                    //       //  }

                                    //       setState(() {
                                    //         // iff dd value is monday then make visble monday card
                                    //         // ignore: unrelated_type_equality_checks

                                    //         selectedValue = value as String;

                                    //       });
                                    //     },
                                    //     buttonStyleData: ButtonStyleData(
                                    //       height: 50,
                                    //       width: 160,
                                    //       padding: const EdgeInsets.only(
                                    //           left: 14, right: 14),
                                    //       decoration: BoxDecoration(
                                    //         borderRadius: BorderRadius.circular(14),
                                    //         border: Border.all(
                                    //           color: Colors.black26,
                                    //         ),
                                    //         color: Colors.redAccent,
                                    //       ),
                                    //       elevation: 2,
                                    //     ),
                                    //     iconStyleData: const IconStyleData(
                                    //       icon: Icon(
                                    //         Icons.arrow_forward_ios_outlined,
                                    //       ),
                                    //       iconSize: 14,
                                    //       iconEnabledColor: Colors.yellow,
                                    //       iconDisabledColor: Colors.grey,
                                    //     ),
                                    //     dropdownStyleData: DropdownStyleData(
                                    //       maxHeight: 200,
                                    //       width: 200,
                                    //       padding: null,
                                    //       decoration: BoxDecoration(
                                    //         borderRadius: BorderRadius.circular(14),
                                    //         color: Colors.redAccent,
                                    //       ),
                                    //       elevation: 8,
                                    //       offset: const Offset(-20, 0),
                                    //       scrollbarTheme: ScrollbarThemeData(
                                    //         radius: const Radius.circular(40),
                                    //         thickness:
                                    //             MaterialStateProperty.all<double>(6),
                                    //         thumbVisibility:
                                    //             MaterialStateProperty.all<bool>(true),
                                    //       ),
                                    //     ),
                                    //     menuItemStyleData: const MenuItemStyleData(
                                    //       height: 40,
                                    //       padding:
                                    //           EdgeInsets.only(left: 14, right: 14),
                                    //     ),
                                    //   ),
                                    // ),
                                    // const SizedBox(
                                    //   width: 150,
                                    // ),
                                    // IconButton(
                                    //     onPressed: () {
                                    //       _decrementCard(this);
                                    //     },
                                    //     icon: const Icon(Icons.delete))
                                  ],
                                ),
                                // timing for appointment
                              ),
                              Divider(),

                              Text(
                                'Book your Appointment Day  ',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: bColor.withOpacity(0.6),
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // **DAy Slot
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 61, 59, 59),
                                                blurRadius: 4,
                                                spreadRadius: 0,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                              Text(
                                'Book your Appointment Time  ',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: bColor.withOpacity(0.6),
                                    fontWeight: FontWeight.bold),
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
                                            color: index == selectValue
                                                ? pColor
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 61, 59, 59),
                                                blurRadius: 4,
                                                spreadRadius: 0,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        floatingActionButton: TextButton.icon(
            onPressed: () {
              setState(() {
                _incrementCard();
              });
            },
            icon: const Icon(Icons.add),
            label: const Text(
              'Book Your Appointment',
              style: TextStyle(fontSize: 20),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat

        // ElevatedButton(
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => JsonOutput(
        //                   day: _selectedDayIndex.toString(),
        //                   timeslot: _selectedTimeIndex.toString(),
        //                 )),
        //       );
        //     },
        //     child: const Text('Book Appointment')),
        // out of card list virw buldr
        );
  }
}
