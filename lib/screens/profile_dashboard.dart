import 'package:async_builder/async_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitster/component_widgets/profile_elements.dart';
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
  String displayName = '';

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      displayName = RegExp(r'^([^@]+)').firstMatch(user.email!)!.group(0)!;
    }
  }

  Future<Map<String, dynamic>> initializeData() async {
    List<dynamic> daysExercised =
        await getDaysExercised(docId: FirebaseAuth.instance.currentUser?.uid);
    Map<String, dynamic> userInformation =
        await getUserInformation(docId: FirebaseAuth.instance.currentUser?.uid);
    return {
      'days_exercised': daysExercised.length,
      'user_information': userInformation,
    };
  }

  String calculateBMI({required double height, required double weight}) {
    if (height == 0) {
      return '0';
    }
    return ((weight) / ((height / 100) * (height / 100))).toStringAsFixed(2);
  }

  double getBurnedCalories({
    required Map<String, dynamic>? initialData,
    required String day,
  }) {
    return ((initialData != null &&
            initialData['user_information']
                .containsKey('weekly_burned_calories'))
        ? initialData['user_information']['weekly_burned_calories'][day]
        : 0) as double;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: AsyncBuilder(
          future: initializeData(),
          builder: (context, value) {
            return SingleChildScrollView(
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
                              (value != null)
                                  ? value['user_information']['fitness_level']
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
                            child: VitalCards(
                              vitalType: 'Age',
                              vitalValue: (value != null && value.isNotEmpty)
                                  ? value['user_information']['age'].toString()
                                  : '',
                            ),
                          ),
                          Expanded(
                            child: VitalCards(
                                vitalType: 'Weight',
                                vitalValue: (value != null && value.isNotEmpty)
                                    ? value['user_information']['weight']
                                        .toString()
                                    : ''),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: VitalCards(
                                vitalType: 'Height',
                                vitalValue: (value != null && value.isNotEmpty)
                                    ? value['user_information']['height']
                                        .toString()
                                    : ''),
                          ),
                          Expanded(
                            child: VitalCards(
                                vitalType: 'BMI',
                                vitalValue: (value != null && value.isNotEmpty)
                                    ? calculateBMI(
                                        height: double.parse(
                                            value['user_information']
                                                ['height']),
                                        weight: double.parse(
                                            value['user_information']
                                                ['weight']))
                                    : ''),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: VitalCards(
                                vitalType: 'Days Exercised',
                                vitalValue: (value != null && value.isNotEmpty)
                                    ? value['days_exercised'].toString()
                                    : ''),
                          ),
                          Expanded(
                            child: VitalCards(
                                vitalType: 'Fitness Goals',
                                vitalValue: (value != null && value.isNotEmpty)
                                    ? value['user_information']['fitness_goals']
                                        .toString()
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
                              measure: getBurnedCalories(
                                initialData: value,
                                day: 'monday',
                              ),
                            ),
                            OrdinalData(
                              domain: 'Tue',
                              measure: getBurnedCalories(
                                  initialData: value, day: 'tuesday'),
                            ),
                            OrdinalData(
                              domain: 'Wed',
                              measure: getBurnedCalories(
                                  initialData: value, day: 'wednesday'),
                            ),
                            OrdinalData(
                              domain: 'Thu',
                              measure: getBurnedCalories(
                                  initialData: value, day: 'thursday'),
                            ),
                            OrdinalData(
                              domain: 'Frid',
                              measure: getBurnedCalories(
                                  initialData: value, day: 'friday'),
                            ),
                            OrdinalData(
                              domain: 'Sat',
                              measure: getBurnedCalories(
                                  initialData: value, day: 'saturday'),
                            ),
                            OrdinalData(
                              domain: 'Sun',
                              measure: getBurnedCalories(
                                  initialData: value, day: 'sunday'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          waiting: (context) => const Text('loading'),
          error: (context, error, stackTrace) => Text('Error! $error')),
    );
  }
}
