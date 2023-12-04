import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitster/services/db_operations.dart';
import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';
import 'package:d_chart/d_chart.dart';

class ProfileDashboard extends StatefulWidget {
  const ProfileDashboard({super.key});

  @override
  State<ProfileDashboard> createState() => _ProfileDashboardState();
}

class _ProfileDashboardState extends State<ProfileDashboard> {
  Map<String, dynamic> initialData = {};
  var displayName = '';
  int daysExercised = 0;

  @override
  void initState() {
    super.initState();
    initializeData().then((data) {
      User? user = FirebaseAuth.instance.currentUser;
      if (data.isNotEmpty) {
        setState(() {
          if (user != null) {
            final name = user.providerData[0];
            displayName = name.displayName!;
            initialData = data['user_information'];
            daysExercised = data['days_exercised'];
          } else {
            initialData = data['user_information'];
            daysExercised = data['days_exercised'];
          }
        });
      }
    });
  }

  Future<Map<String, dynamic>> initializeData() async {
    List<dynamic> daysExercised =
        await getDaysExercised(docId: 'uZoLJiYAwDUYpd17VLHttlETltf2');
    Map<String, dynamic> userInformation =
        await getUserInformation(docId: 'uZoLJiYAwDUYpd17VLHttlETltf2');
    // return await getUserInformation(docId: 'uZoLJiYAwDUYpd17VLHttlETltf2');
    return {
      'days_exercised': daysExercised.length,
      'user_information': userInformation,
    };
  }

  String calculateBMI({required double height, required double weight}) {
    return ((weight) / ((height / 100) * (height / 100))).toStringAsFixed(2);
  }

  double getBurnedCalorie({required String day}) {
    return ((initialData.isNotEmpty &&
            initialData.containsKey('weekly_burned_calories'))
        ? initialData['weekly_burned_calories'][day]
        : 0) as double;
  }

  Card _vitalCards({
    required String vitalType,
    required String vitalValue,
  }) {
    return Card(
      shape: BeveledRectangleBorder(
        side: BorderSide(
          color: HexColor('#9AB8F9'),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                vitalType,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              vitalValue,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: WidgetCircularAnimator(
                innerColor: HexColor('#0C4ACF'),
                outerColor: HexColor('#020A1D'),
                child: CircularProfileAvatar(
                  '',
                  borderColor: HexColor('#9AB8F9'),
                  borderWidth: 3,
                  elevation: 5,
                  radius: 90,
                  child: Image.asset(
                    '../lib/images/Push_Person.png',
                  ),
                ),
              ),
            ),
            // Center(
            //   child: CircularProfileAvatar(
            //     '',
            //     borderColor: HexColor('#9AB8F9'),
            //     borderWidth: 3,
            //     elevation: 5,
            //     radius: 90,
            //     child: Image.asset(
            //       '../lib/images/Push_Person.png',
            //     ),
            //   ),
            // ),
            const Gap(10),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        (FirebaseAuth.instance.currentUser != null)
                            ? displayName
                            : '',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    width: 20,
                    thickness: 2,
                    endIndent: 0,
                    color: HexColor('#0C4ACF'),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        (initialData.isNotEmpty)
                            ? initialData['fitness_level'].toString()
                            : '',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(10),
            const Text(
              'User Information',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              thickness: 2,
              color: HexColor('#0C4ACF'),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _vitalCards(
                          vitalType: 'Age',
                          vitalValue: (initialData.isNotEmpty)
                              ? initialData['age'].toString()
                              : ''),
                    ),
                    Expanded(
                      child: _vitalCards(
                          vitalType: 'Weight',
                          vitalValue: (initialData.isNotEmpty)
                              ? initialData['weight'].toString()
                              : ''),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _vitalCards(
                          vitalType: 'Height',
                          vitalValue: (initialData.isNotEmpty)
                              ? initialData['height'].toString()
                              : ''),
                    ),
                    Expanded(
                      child: _vitalCards(
                          vitalType: 'BMI',
                          vitalValue: (initialData.isNotEmpty)
                              ? calculateBMI(
                                  height: double.parse(initialData['height']),
                                  weight: double.parse(initialData['weight']))
                              : ''),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _vitalCards(
                          vitalType: 'Days Exercised',
                          vitalValue: daysExercised.toString()),
                    ),
                    Expanded(
                      child: _vitalCards(
                          vitalType: 'Fitness Goals',
                          vitalValue: (initialData.isNotEmpty)
                              ? initialData['fitness_goals'].toString()
                              : ''),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(10),
            const Text(
              'Calories Burned This Week',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              thickness: 2,
              color: HexColor('#0C4ACF'),
            ),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: DChartBarO(
                groupList: [
                  OrdinalGroup(
                    id: '1',
                    data: [
                      OrdinalData(
                        domain: 'Mon',
                        measure: getBurnedCalorie(day: 'monday'),
                      ),
                      OrdinalData(
                          domain: 'Tue',
                          measure: getBurnedCalorie(day: 'tuesday')),
                      OrdinalData(
                          domain: 'Wed',
                          measure: getBurnedCalorie(day: 'wednesday')),
                      OrdinalData(
                          domain: 'Thu',
                          measure: getBurnedCalorie(day: 'thursday')),
                      OrdinalData(
                          domain: 'Frid',
                          measure: getBurnedCalorie(day: 'friday')),
                      OrdinalData(
                          domain: 'Sat',
                          measure: getBurnedCalorie(day: 'saturday')),
                      OrdinalData(
                          domain: 'Sun',
                          measure: getBurnedCalorie(day: 'sunday')),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
