import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class WorkoutTracker extends StatelessWidget {
  const WorkoutTracker({super.key});

  Card _targetMuscleCard(String muscleName) {
    return Card(
      color: HexColor('#9AB8F9'),
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(Icons.star),
            Text(
              muscleName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Calendar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 100,
                color: Colors.amberAccent,
              ),
            ),
            const SizedBox(
              height: 5,
              width: 5,
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(6),
                color: HexColor('#FBFBAD'),
                child: Column(
                  children: [
                    const Text(
                      'Today\'s Training Volume',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Card(
                              color: HexColor('#9AB8F9'),
                              child: const Center(
                                child: Text(
                                  '15 Sets',
                                  style: TextStyle(
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
                            flex: 1,
                            child: Card(
                              color: HexColor('#9AB8F9'),
                              child: const Center(
                                child: Text(
                                  '15 Sets',
                                  style: TextStyle(
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
            ),
            const SizedBox(
              height: 5,
              width: 5,
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.greenAccent,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.amberAccent,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: HexColor('#FBFBAD'),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Text(
                                  'Target Muscles',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    _targetMuscleCard('Back'),
                                    _targetMuscleCard('Chest'),
                                    _targetMuscleCard('Biceps'),
                                    _targetMuscleCard('Biceps'),
                                    _targetMuscleCard('Biceps'),
                                  ],
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
            ),
          ],
        ),
      ),
    );
  }
}
