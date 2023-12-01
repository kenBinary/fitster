import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitster/models/workout_splits.dart';
import 'package:fitster/services/db_operations.dart';
import 'package:fitster/services/workout_plan_builder.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CreateWorkoutPage extends StatefulWidget {
  const CreateWorkoutPage({super.key});

  @override
  State<CreateWorkoutPage> createState() => _CreateWorkoutPageState();
}

MaterialButton fitnessLevelButton({
  required String selectedButton,
  required String text,
  required Function setFitnessLevel,
}) {
  return MaterialButton(
    onPressed: () {
      setFitnessLevel();
    },
    color: selectedButton == text ? const Color(0xfffbfbad) : Colors.white,
    minWidth: 40,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Text(
      text,
      style: const TextStyle(fontSize: 13),
    ),
  );
}

Column splitSelectorButton({
  required String imagePath,
  required String text,
  required Function setSelectedSplit,
}) {
  return Column(
    children: [
      MaterialButton(
        onPressed: () {
          setSelectedSplit();
        },
        child: Container(
          width: 60.0,
          height: 60.0,
          decoration: const BoxDecoration(
            color: Color(0xFF9AB8F9),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Image.asset(
              imagePath,
              height: 40.0,
              width: 40.0,
            ),
          ),
        ),
      ),
      const SizedBox(height: 8.0),
      Text(text),
    ],
  );
}

Padding inputLabel({required String text}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

Expanded inputField({
  required TextEditingController controller,
  required String hintText,
}) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        child: TextField(
          cursorColor: const Color(0xFF9AB8F9),
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xfffbfbad),
            hintText: hintText,
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

class _CreateWorkoutPageState extends State<CreateWorkoutPage> {
  final ageFieldController = TextEditingController();
  final heightFieldController = TextEditingController();
  final weightFieldController = TextEditingController();

  String userName = ' ';
  String fitnessLevel = '';
  String selectedSplit = '';

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
                    color: HexColor('#9AB8F9'),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Row(
                      children: [
                        Expanded(
                          child: fitnessLevelButton(
                              selectedButton: fitnessLevel,
                              text: 'Beginner',
                              setFitnessLevel: () {
                                setState(() {
                                  fitnessLevel = 'Beginner';
                                });
                              }),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: fitnessLevelButton(
                              selectedButton: fitnessLevel,
                              text: 'Intermediate',
                              setFitnessLevel: () {
                                setState(() {
                                  fitnessLevel = 'Intermediate';
                                });
                              }),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: fitnessLevelButton(
                              selectedButton: fitnessLevel,
                              text: 'Advanced',
                              setFitnessLevel: () {
                                setState(() {
                                  fitnessLevel = 'Advanced';
                                });
                              }),
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
                splitSelectorButton(
                  imagePath: '../lib/images/C_Logo.png',
                  text: 'Bro Split',
                  setSelectedSplit: () {
                    setState(() {
                      selectedSplit = 'bro_split';
                    });
                  },
                ),
                splitSelectorButton(
                  imagePath: '../lib/images/BS_Logo.png',
                  text: 'Push-Pull-Legs',
                  setSelectedSplit: () {
                    setState(() {
                      selectedSplit = 'push_pull_legs';
                    });
                  },
                ),
                splitSelectorButton(
                  imagePath: '../lib/images/FL_Logo.png',
                  text: 'Upper-Lower',
                  setSelectedSplit: () {
                    setState(() {
                      selectedSplit = 'upper_lower';
                    });
                  },
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
          inputLabel(text: 'Age'),
          inputField(
            controller: ageFieldController,
            hintText: 'What is your Age?',
          ),
          inputLabel(text: 'Height'),
          inputField(
            controller: heightFieldController,
            hintText: 'What is your Height?',
          ),
          inputLabel(text: 'Weight'),
          inputField(
            controller: weightFieldController,
            hintText: 'What is your Weight?',
          ),
          Expanded(
            child: MaterialButton(
              onPressed: () async {
                if (FirebaseAuth.instance.currentUser != null) {
                  String? userId = FirebaseAuth.instance.currentUser?.uid;
                  WorkoutSplit mySplit = await createWorkoutPlan(selectedSplit);
                  await addSplitToFirestore(
                    docId: userId,
                    jsonData: mySplit.toJson(),
                  );
                  await addUserInformationToFirestore(
                    docId: userId,
                    jsonData: {
                      'fitness_level': fitnessLevel,
                      'fitness_goals': dropDownValue,
                      'age': ageFieldController.text,
                      'height': heightFieldController.text,
                      'weight': weightFieldController.text,
                    },
                  );
                } else {}
              },
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
