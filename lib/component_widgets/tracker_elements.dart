import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitster/component_widgets/helper_functions.dart';
import 'package:fitster/services/db_operations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:hexcolor/hexcolor.dart';

class TargetMuscleCard extends StatelessWidget {
  const TargetMuscleCard({
    super.key,
    required this.muscleName,
  });
  final String muscleName;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: HexColor('#9AB8F9'),
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset(
                  getRandomMuscleGroupImage(),
                ),
              ),
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
}

class VolumeCard extends StatelessWidget {
  const VolumeCard({
    super.key,
    required this.volumeType,
    required this.volumeValue,
  });
  final String volumeType;
  final String volumeValue;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: HexColor('#9AB8F9'),
      child: Center(
        child: Text(
          '$volumeValue $volumeType',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class TargetMuscleSection extends StatelessWidget {
  const TargetMuscleSection({
    super.key,
    required this.targetMuscleCount,
    required this.muscleName,
  });
  final int targetMuscleCount;
  final List<dynamic> muscleName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                    itemCount: targetMuscleCount,
                    itemBuilder: (context, index) {
                      if (targetMuscleCount > 0) {
                        return TargetMuscleCard(
                            muscleName: muscleName[index].toString());
                      }
                      return const Text(
                        'No Created Workout Plan',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    return await getDaysExercised(
        docId: FirebaseAuth.instance.currentUser?.uid);
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
