import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitster/services/db_operations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';

class MyHeatMapCalendar extends StatefulWidget {
  const MyHeatMapCalendar({
    super.key,
  });

  @override
  State<MyHeatMapCalendar> createState() => _MyHeatMapCalendarState();
}

class _MyHeatMapCalendarState extends State<MyHeatMapCalendar> {
  Map<DateTime, int> myDataSet = {};

  @override
  void initState() {
    Map<DateTime, int> newDataSet = {};
    super.initState();
    initializeDataSet().then((initialData) {
      if (initialData.isNotEmpty) {
        for (var date in initialData) {
          newDataSet.putIfAbsent(date.toDate(), () => 2);
        }
      }
      setState(() {
        myDataSet = newDataSet;
      });
    });
  }

  Future<List<dynamic>> initializeDataSet() async {
    return await getDaysExercised(docId: 'uZoLJiYAwDUYpd17VLHttlETltf2');
  }

  @override
  Widget build(BuildContext context) {
    return HeatMapCalendar(
      defaultColor: HexColor('#9AB8F9'),
      colorMode: ColorMode.color,
      fontSize: 16,
      monthFontSize: 16,
      textColor: HexColor('#000000'),
      showColorTip: false,
      datasets: myDataSet,
      colorsets: {
        1: HexColor('#FBFBAD'),
      },
      onClick: (value) {
        setState(() {
          if (myDataSet.containsKey(value)) {
            myDataSet.remove(value);
            updateExerciseDates(
              docId: FirebaseAuth.instance.currentUser?.uid,
              jsonData: {
                'days_exercised': myDataSet.keys.toList(),
              },
            );
          } else {
            myDataSet.putIfAbsent(value, () => 2);
            updateExerciseDates(
              docId: FirebaseAuth.instance.currentUser?.uid,
              jsonData: {
                'days_exercised': myDataSet.keys.toList(),
              },
            );
          }
        });
      },
    );
  }
}

class WorkoutTracker extends StatefulWidget {
  const WorkoutTracker({super.key});

  @override
  State<WorkoutTracker> createState() => _WorkoutTrackerState();
}

class _WorkoutTrackerState extends State<WorkoutTracker> {
  Map<String, dynamic> initialData = {};

  @override
  void initState() {
    super.initState();
    initializeDataSets().then((initialDataSet) {
      if (initialDataSet.isNotEmpty) {
        setState(() {
          initialData = initialDataSet;
        });
      }
    });
  }

  Future<Map<String, dynamic>> initializeDataSets() async {
    List<dynamic> targetMuscles =
        await getTargetMuscles(docId: 'uZoLJiYAwDUYpd17VLHttlETltf2');
    Map<String, int> trainingVolume =
        await getTrainingVolume(docId: 'uZoLJiYAwDUYpd17VLHttlETltf2');
    return {
      'target_muscles': targetMuscles,
      'training_volume': trainingVolume,
    };
  }

  Card _targetMuscleCard(String muscleName) {
    return Card(
      color: HexColor('#9AB8F9'),
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Expanded(
              flex: 2,
              child: Icon(Icons.star),
            ),
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  muscleName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
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
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Days Exercised',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const MyHeatMapCalendar(),
            const SizedBox(
              height: 5,
              width: 5,
            ),
            Container(
              height: 105,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                color: HexColor('#FBFBAD'),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Today\'s Training Volume',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(5),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            color: HexColor('#9AB8F9'),
                            child: Center(
                              child: Text(
                                (initialData.isEmpty)
                                    ? 'Sets'
                                    : '${initialData['training_volume']['reps']} Sets',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Card(
                            color: HexColor('#9AB8F9'),
                            child: Center(
                              child: Text(
                                (initialData.isEmpty)
                                    ? 'Sets'
                                    : '${initialData['training_volume']['sets']} Reps',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Gap(5),
            SizedBox(
              height: 400,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: HexColor('#FBFBAD'),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                          'Target Muscles',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: (initialData.isNotEmpty)
                              ? initialData['target_muscles'].length
                              : 1,
                          itemBuilder: (context, index) {
                            if (initialData.isNotEmpty) {
                              return _targetMuscleCard(
                                initialData['target_muscles'][index],
                              );
                            } else {
                              return const Text(
                                'No Created Workout Plan',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                          },
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
    );
  }
}
