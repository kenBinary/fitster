import 'package:async_builder/async_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitster/component_widgets/tracker_elements.dart';
import 'package:fitster/services/db_operations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logo_n_spinner/logo_n_spinner.dart';

class WorkoutTracker extends StatefulWidget {
  const WorkoutTracker({super.key});

  @override
  State<WorkoutTracker> createState() => _WorkoutTrackerState();
}

class _WorkoutTrackerState extends State<WorkoutTracker> {
  Future<Map<String, dynamic>> initializeDataSets() async {
    List<dynamic> targetMuscles =
        await getTargetMuscles(docId: FirebaseAuth.instance.currentUser?.uid);
    Map<String, int> trainingVolume =
        await getTrainingVolume(docId: FirebaseAuth.instance.currentUser?.uid);
    return {
      'target_muscles': targetMuscles,
      'training_volume': trainingVolume,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AsyncBuilder(
        future: initializeDataSets(),
        waiting: (context) {
          return Center(
            child: LogoandSpinner(
              imageAssets: 'assets/images/fitster-icon.png',
              reverse: true,
              arcColor: HexColor('#0C4ACF'),
              spinSpeed: const Duration(milliseconds: 500),
            ),
          );
        },
        builder: (context, value) {
          return SingleChildScrollView(
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
                              child: VolumeCard(
                                volumeType: 'Sets',
                                volumeValue: (value != null)
                                    ? value['training_volume']['reps']
                                        .toString()
                                    : '',
                              ),
                            ),
                            const Gap(10),
                            Expanded(
                              child: VolumeCard(
                                volumeType: 'Reps',
                                volumeValue: (value != null)
                                    ? value['training_volume']['sets']
                                        .toString()
                                    : '',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(5),
                TargetMuscleSection(
                  targetMuscleCount:
                      (value != null) ? value['target_muscles'].length : 0,
                  muscleName: (value != null)
                      ? value['target_muscles']
                      : [] as List<String>,
                ),
              ],
            ),
          );
        },
        error: (context, error, stackTrace) => Text('Error! $error'),
      ),
    );
  }
}
