import 'package:flutter/material.dart';

class creatworkout_page extends StatefulWidget {
  const creatworkout_page({super.key, required String title});

  @override
  State<creatworkout_page> createState() => _creatworkout_pageState();
}

class _creatworkout_pageState extends State<creatworkout_page> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            children: [
              Text(
                'What is your fitness level?',
                style: TextStyle(
                  fontFamily: 'Grotesco',
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                child: Container(
                  color: const Color(0xFF9AB8F9),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
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
                        MaterialButton(
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
                        MaterialButton(
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 15.0, right: 80.0),
          child: Text(
            'What is your fitness goal?',
            style: TextStyle(fontFamily: 'Grotesco', fontSize: 20.0),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 5.0, left: 35.0, right: 35.0),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: dropDownValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
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
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 5.0, bottom: 8.0, right: 80.0),
          child: Text(
            'Select your workout split',
            style: TextStyle(fontFamily: 'Grotesco', fontSize: 20.0),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                MaterialButton(
                  onPressed: () {},
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFF9AB8F9),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset('../lib/images/C_Logo.png',
                          height: 40.0, width: 40.0),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text('Cardio'),
              ],
            ),
            const SizedBox(width: 40),
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
                      child: Image.asset('../lib/images/BS_Logo.png',
                          height: 40.0, width: 40.0),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text('Bro Split'),
              ],
            ),
            const SizedBox(width: 40),
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
                      child: Image.asset('../lib/images/FL_Logo.png',
                          height: 40.0, width: 40.0),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text('Fullbody'),
              ],
            ),
          ],
        ),
        const Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 8.0, right: 80.0),
              child: Text(
                'Select your workout split',
                style: TextStyle(fontFamily: 'Grotesco', fontSize: 20.0),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Age',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 30,
            width: 400,
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
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Height',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 30,
            width: 400,
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
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Weight',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 30,
            width: 400,
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
        MaterialButton(
          onPressed: () {},
          child: Container(
            width: 400,
            height: 30,
            color: const Color(0xFF9AB8F9),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                'Submit',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
