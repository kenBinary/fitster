import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitster/component_widgets/create_workout_elements.dart';
import 'package:fitster/component_widgets/form_elements.dart';
import 'package:fitster/services/db_operations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CreateWorkoutPage extends StatefulWidget {
  const CreateWorkoutPage({super.key});

  @override
  State<CreateWorkoutPage> createState() => _CreateWorkoutPageState();
}

class _CreateWorkoutPageState extends State<CreateWorkoutPage> {
  List<String> userGoal = [
    'Lose Weight',
    'Gain Muscles',
    'Develop 6 Packs',
    'Gain 4 nipples'
  ];
  final _formKey = GlobalKey<FormState>();
  String fitnessGoal = 'Lose Weight';
  String fitnessLevel = 'Beginner';
  String selectedSplit = 'bro_split';

  MyTextFormField ageField = MyTextFormField(
    validatorCallback: (value) {
      final isDigit = RegExp(r'^[0-9]+$');
      if (value!.isEmpty || value.length >= 4 || !isDigit.hasMatch(value)) {
        return '';
      }
      return null;
    },
    hintText: '21',
  );
  MyTextFormField heightField = MyTextFormField(
    validatorCallback: (value) {
      final isDigit = RegExp(r'^[0-9]+$');
      if (value!.isEmpty || value.length >= 4 || !isDigit.hasMatch(value)) {
        return '';
      }
      return null;
    },
    hintText: 'enter in cm e.g. (173)',
  );
  MyTextFormField weightField = MyTextFormField(
    validatorCallback: (value) {
      final isDigit = RegExp(r'^[0-9]+$');
      if (value!.isEmpty || value.length >= 4 || !isDigit.hasMatch(value)) {
        return '';
      }
      return null;
    },
    hintText: 'enter in kg e.g. (65)',
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Your Fitness Level',
              style: TextStyle(
                fontFamily: 'Grotesco',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(10),
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
                      child: FitnessLevelButton(
                        selectedButton: fitnessLevel,
                        text: 'Beginner',
                        setFitnessLevel: () {
                          setState(() {
                            fitnessLevel = 'Beginner';
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: FitnessLevelButton(
                        selectedButton: fitnessLevel,
                        text: 'Intermediate',
                        setFitnessLevel: () {
                          setState(() {
                            fitnessLevel = 'Intermediate';
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: FitnessLevelButton(
                        selectedButton: fitnessLevel,
                        text: 'Expert',
                        setFitnessLevel: () {
                          setState(() {
                            fitnessLevel = 'Expert';
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(5),
            const Text(
              'What is your fitness goal?',
              style: TextStyle(
                fontFamily: 'Grotesco',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(5),
            Expanded(
              child: DropdownButton<String>(
                isExpanded: true,
                value: fitnessGoal,
                icon: const Icon(Icons.arrow_drop_down),
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
                    fitnessGoal = newValue!;
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
            const Gap(5),
            const Text(
              'Select your workout split',
              style: TextStyle(
                fontFamily: 'Grotesco',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SplitSelectorButton(
                  selectedSplit: selectedSplit,
                  imagePath: '../lib/images/bro_split.png',
                  text: 'Bro Split',
                  setSelectedSplit: () {
                    setState(() {
                      selectedSplit = 'Bro Split';
                    });
                  },
                ),
                SplitSelectorButton(
                  selectedSplit: selectedSplit,
                  imagePath: '../lib/images/BS_Logo.png',
                  text: 'Push-Pull-Legs',
                  setSelectedSplit: () {
                    setState(() {
                      selectedSplit = 'Push-Pull-Legs';
                    });
                  },
                ),
                SplitSelectorButton(
                  selectedSplit: selectedSplit,
                  imagePath: '../lib/images/FL_Logo.png',
                  text: 'Upper-Lower',
                  setSelectedSplit: () {
                    setState(() {
                      selectedSplit = 'Upper-Lower';
                    });
                  },
                ),
              ],
            ),
            const Gap(10),
            const Text(
              'Enter Your Vital Details',
              style: TextStyle(
                fontFamily: 'Grotesco',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(10),
            const InputLabel(text: 'Age'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ageField,
            ),
            const InputLabel(text: 'Height'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: heightField,
            ),
            const InputLabel(text: 'Weight'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: weightField,
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () async {
                  User? user = FirebaseAuth.instance.currentUser;
                  if (_formKey.currentState!.validate() && user != null) {
                    String? userId = user.uid;
                    await createNewWorkoutSplit(
                      docId: userId,
                      selectedSplit: selectedSplit,
                      fitnessLevel: fitnessLevel,
                      fitnessGoal: fitnessGoal,
                      age: ageField.getText(),
                      height: heightField.getText(),
                      weight: weightField.getText(),
                    );
                    if (mounted) {
                      showTopSnackBar(
                        Overlay.of(context),
                        const CustomSnackBar.success(
                          message: 'Success',
                        ),
                      );
                    }
                  } else {
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.error(
                        message: 'Enter Correct Input Format',
                      ),
                    );
                  }
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
      ),
    );
  }
}
