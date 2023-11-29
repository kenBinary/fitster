import 'package:flutter/material.dart';

class ProfileDashboard extends StatelessWidget {
  const ProfileDashboard({super.key});
  Card _vitalCards(
      {required String vitalType,
      required String vitalValue,
      required double fontSize}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vitalType,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(1000),
                      ),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        vitalValue,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize,
                        ),
                      ),
                    ),
                  ),
                ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(45),
                    ),
                    color: Colors.black,
                  ),
                  height: 80,
                  width: 80,
                  // color: Colors.black,
                ),
                const SizedBox(
                  width: 15,
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Jhon Doe',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Beginner',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: _vitalCards(
                      vitalType: 'Age', vitalValue: '23', fontSize: 20),
                ),
                Expanded(
                  flex: 1,
                  child: _vitalCards(
                      vitalType: 'Weight', vitalValue: '70kg', fontSize: 20),
                ),
                Expanded(
                  flex: 1,
                  child: _vitalCards(
                      vitalType: 'Height', vitalValue: '1.73m', fontSize: 20),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: _vitalCards(
                      vitalType: 'BMI', vitalValue: '23', fontSize: 30),
                ),
                Expanded(
                  flex: 1,
                  child: _vitalCards(
                      vitalType: 'Exercise Days',
                      vitalValue: '70kg',
                      fontSize: 30),
                ),
              ],
            ),
          ),
          const Text(
            'Calories Burned This Week',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
