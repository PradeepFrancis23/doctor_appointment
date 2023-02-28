import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool _mondayCardVisible = false;
  var _addCard = 1;
  // **increment fucnt
  void _incrementCard() {
    setState(() {
      _addCard++;
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
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 200,
              width: 500,
              child: Expanded(
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
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //  dd for day seletion
                            DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    Icon(
                                      Icons.list,
                                      size: 16,
                                      color: Colors.yellow,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Select Day',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.yellow,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: items
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: selectedValue,
                                onChanged: (value) {
                                  //**  add new card below the existing card */

                                  setState(() {
                                    // iff dd value is monday then make visble monday card
                                    // ignore: unrelated_type_equality_checks
                                    if (items.contains('Tuesday')) {
                                      _mondayCardVisible = true;
                                    } else {
                                      _mondayCardVisible = false;
                                    }

                                    selectedValue = value as String;
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  width: 160,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                    color: Colors.redAccent,
                                  ),
                                  elevation: 2,
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                  ),
                                  iconSize: 14,
                                  iconEnabledColor: Colors.yellow,
                                  iconDisabledColor: Colors.grey,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  width: 200,
                                  padding: null,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.redAccent,
                                  ),
                                  elevation: 8,
                                  offset: const Offset(-20, 0),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness:
                                        MaterialStateProperty.all<double>(6),
                                    thumbVisibility:
                                        MaterialStateProperty.all<bool>(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 250,
                            ),
                            Expanded(
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete)),
                            )
                          ],
                        ),
                        // timing for appointment
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: const [
                            Chip(label: Text('9:00 am')),
                            SizedBox(
                              width: 10,
                            ),
                            Chip(label: Text('9:30 am')),
                            SizedBox(
                              width: 10,
                            ),
                            Chip(label: Text('10:00 am')),
                            SizedBox(
                              width: 10,
                            ),
                            Chip(label: Text('10:30 am')),
                            SizedBox(
                              width: 10,
                            ),
                            Chip(label: Text('11:00 am')),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: const [
                                Chip(label: Text('11:30 am')),
                                SizedBox(
                                  width: 10,
                                ),
                                Chip(label: Text('12:00 pm')),
                                SizedBox(
                                  width: 10,
                                ),
                                Chip(label: Text('12:30 pm')),
                                SizedBox(
                                  width: 10,
                                ),
                                Chip(label: Text('1:00 pm')),
                                SizedBox(
                                  width: 10,
                                ),
                                Chip(label: Text('1:30 pm')),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // monday card
          Visibility(
            visible: _mondayCardVisible,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 200,
                width: 500,
                child: Expanded(
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
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //  dd for day seletion
                              DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  isExpanded: true,
                                  hint: Row(
                                    children: const [
                                      Icon(
                                        Icons.list,
                                        size: 16,
                                        color: Colors.yellow,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Select Day',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.yellow,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  items: items
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                      .toList(),
                                  value: selectedValue,
                                  onChanged: (value) {
                                    //**  add new card below the existing card */
                                    _incrementCard;
                                    setState(() {
                                      selectedValue = value as String;
                                    });
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: 50,
                                    width: 160,
                                    padding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: Colors.black26,
                                      ),
                                      color: Colors.redAccent,
                                    ),
                                    elevation: 2,
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                    ),
                                    iconSize: 14,
                                    iconEnabledColor: Colors.yellow,
                                    iconDisabledColor: Colors.grey,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 200,
                                    width: 200,
                                    padding: null,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.redAccent,
                                    ),
                                    elevation: 8,
                                    offset: const Offset(-20, 0),
                                    scrollbarTheme: ScrollbarThemeData(
                                      radius: const Radius.circular(40),
                                      thickness:
                                          MaterialStateProperty.all<double>(6),
                                      thumbVisibility:
                                          MaterialStateProperty.all<bool>(true),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                    padding:
                                        EdgeInsets.only(left: 14, right: 14),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 250,
                              ),
                              Expanded(
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.delete)),
                              )
                            ],
                          ),
                          // timing for appointment
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: const [
                              Chip(label: Text('9:00 am')),
                              SizedBox(
                                width: 10,
                              ),
                              Chip(label: Text('9:30 am')),
                              SizedBox(
                                width: 10,
                              ),
                              Chip(label: Text('10:00 am')),
                              SizedBox(
                                width: 10,
                              ),
                              Chip(label: Text('10:30 am')),
                              SizedBox(
                                width: 10,
                              ),
                              Chip(label: Text('11:00 am')),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: const [
                                  Chip(label: Text('11:30 am')),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Chip(label: Text('12:00 pm')),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Chip(label: Text('12:30 pm')),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Chip(label: Text('1:00 pm')),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Chip(label: Text('1:30 pm')),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
