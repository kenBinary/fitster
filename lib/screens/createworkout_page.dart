import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CreateWorkoutPage extends StatefulWidget {
  const CreateWorkoutPage({super.key});

  @override
  State<CreateWorkoutPage> createState() => _CreateWorkoutPageState();
}

class _CreateWorkoutPageState extends State<CreateWorkoutPage> {
  final textController1 = TextEditingController();
  final textController2 = TextEditingController();
  final textController3 = TextEditingController();

  String userName = ' ';
  String selectedButton = '';

  List<String> userGoal = [
    'Lose Weight',
    'Gain Muscles',
    'Develop 6 Packs',
    'Gain 4 nipples'
  ];

  String dropDown = '';
  String dropDownValue = '';

  @override
  void initState() {
    super.initState();
    dropDown = userGoal[0];
    dropDownValue = userGoal[0];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              bottom: 10,
            ),
            child: Text(
              'Select Your Fitness Level',
              style: TextStyle(
                fontFamily: 'Grotesco',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: HexColor('#9AB8F9')),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                selectedButton = 'Beginner';
                              });
                            },
                            color: selectedButton == 'Beginner'
                                ? const Color(0xfffbfbad)
                                : Colors.white,
                            minWidth: 40,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: const Text(
                              'Beginner',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                selectedButton = 'Intermediate';
                              });
                            },
                            color: selectedButton == 'Intermediate'
                                ? const Color(0xfffbfbad)
                                : Colors.white,
                            minWidth: 40,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: const Text(
                              'Intermediate',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                selectedButton = 'Advanced';
                              });
                            },
                            color: selectedButton == 'Advanced'
                                ? const Color(0xfffbfbad)
                                : Colors.white,
                            minWidth: 40,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: const Text(
                              'Advanced',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 5,
              bottom: 5,
            ),
            child: Text(
              'What is your fitness goal?',
              style: TextStyle(
                fontFamily: 'Grotesco',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: DropdownButton<String>(
              isExpanded: true,
              value: dropDownValue,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              underline: Container(
                height: 2,
                color: const Color(0xFF9AB8F9),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropDownValue = newValue!;
                });
              },
              items: userGoal.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 5,
              bottom: 5,
            ),
            child: Text(
              'Select your workout split',
              style: TextStyle(
                fontFamily: 'Grotesco',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    MaterialButton(
                      onPressed: () {},
                      child: Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: const BoxDecoration(
                          color: Color(0xFF9AB8F9),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            '../lib/images/C_Logo.png',
                            height: 40.0,
                            width: 40.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text('Bro Split'),
                  ],
                ),
                Column(
                  children: [
                    MaterialButton(
                      onPressed: () {},
                      child: Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: const BoxDecoration(
                          color: Color(0xFF9AB8F9),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            '../lib/images/BS_Logo.png',
                            height: 40.0,
                            width: 40.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text('Push-Pull-Legs'),
                  ],
                ),
                Column(
                  children: [
                    MaterialButton(
                      onPressed: () {},
                      child: Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: const BoxDecoration(
                          color: Color(0xFF9AB8F9),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            '../lib/images/FL_Logo.png',
                            height: 40.0,
                            width: 40.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text('Upper-Lower'),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Text(
              'Enter Your Vital Details',
              style: TextStyle(
                fontFamily: 'Grotesco',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Age',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                child: TextField(
                  cursorColor: const Color(0xFF9AB8F9),
                  controller: textController1,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xfffbfbad),
                    hintText: 'What is your Age?',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Height',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                child: TextField(
                  cursorColor: const Color(0xFF9AB8F9),
                  controller: textController2,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xfffbfbad),
                    hintText: 'What is your height?',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Weight',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                child: TextField(
                  cursorColor: const Color(0xFF9AB8F9),
                  controller: textController3,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xfffbfbad),
                    hintText: 'What is your Weight?',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: MaterialButton(
              onPressed: () {},
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(13)),
                child: Container(
                  height: 40,
                  color: const Color(0xFF9AB8F9),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
