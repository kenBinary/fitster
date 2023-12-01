import 'package:flutter/material.dart';

class ViewWorkout extends StatefulWidget {
  const ViewWorkout({super.key});

  @override
  State<ViewWorkout> createState() => _ViewWorkoutState();
}

class _ViewWorkoutState extends State<ViewWorkout> {
  double exeNumber = 0.0;
  int sets = 0;
  int reps = 0;
  String minRests = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  color: const Color(0xFF9AB8F9),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 200.0),
                        child: Text(
                          'Push',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                          icon: const Icon(Icons.add_box_outlined),
                          iconSize: 30.0,
                          onPressed: () {
                            exeNumber += 1;
                          }),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  color: const Color(0xfffbfbad),
                  height: 100.0,
                  child: Row(
                    children: [
                      // First Column
                      Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Exercise: $exeNumber',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 8, left: 8, right: 8),
                            child: Row(
                              children: [
                                Text(
                                  '$sets sets',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '$reps reps',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 8, left: 8, right: 8),
                            child: Text(
                              '$minRests minutes rest',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            '../lib/images/Push_Person.png',
                            height: 100,
                            width: 100,
                          )
                        ],
                      ),

                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                              onPressed: () {},
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                child: Container(
                                    height: 30,
                                    width: 50,
                                    color: const Color(0xFF9AB8F9),
                                    child: const Align(
                                        alignment: Alignment.center,
                                        child: Text('Edit'))),
                              )),
                          const SizedBox(height: 10),
                          MaterialButton(
                              onPressed: () {},
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                child: Container(
                                    height: 30,
                                    width: 50,
                                    color: const Color(0xFF9AB8F9),
                                    child: const Align(
                                        alignment: Alignment.center,
                                        child: Text('Delete'))),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  color: const Color(0xfffbfbad),
                  height: 100.0,
                  child: Row(
                    children: [
                      // First Column
                      Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Exercise: $exeNumber',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 8, left: 8, right: 8),
                            child: Row(
                              children: [
                                Text(
                                  '$sets sets',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '$reps reps',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 8, left: 8, right: 8),
                            child: Text(
                              '$minRests minutes rest',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            '../lib/images/Push_Person.png',
                            height: 100,
                            width: 100,
                          )
                        ],
                      ),

                      const SizedBox(width: 20),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                              onPressed: () {},
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                child: Container(
                                  height: 30,
                                  width: 50,
                                  color: const Color(0xFF9AB8F9),
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Text('Edit'),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 10),
                          MaterialButton(
                            onPressed: () {},
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                              child: Container(
                                height: 30,
                                width: 50,
                                color: const Color(0xFF9AB8F9),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Text('Delete'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  color: const Color(0xFF9AB8F9),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 200.0),
                        child: Text(
                          'Pull',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                          icon: const Icon(Icons.add_box_outlined),
                          iconSize: 30.0,
                          onPressed: () {
                            exeNumber += 1;
                          }),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  color: const Color(0xfffbfbad),
                  height: 100.0,
                  child: Row(
                    children: [
                      // First Column
                      Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Exercise: $exeNumber',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 8, left: 8, right: 8),
                            child: Row(
                              children: [
                                Text(
                                  '$sets sets',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '$reps reps',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 8, left: 8, right: 8),
                            child: Text(
                              '$minRests minutes rest',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            '../lib/images/Pull_Person.png',
                            height: 80,
                            width: 100,
                          )
                        ],
                      ),

                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                              onPressed: () {},
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                child: Container(
                                  height: 30,
                                  width: 50,
                                  color: const Color(0xFF9AB8F9),
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Text('Edit'),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 10),
                          MaterialButton(
                            onPressed: () {},
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                              child: Container(
                                height: 30,
                                width: 50,
                                color: const Color(0xFF9AB8F9),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Text('Delete'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  color: const Color(0xfffbfbad),
                  height: 100.0,
                  child: Row(
                    children: [
                      // First Column
                      Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Exercise: $exeNumber',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 8, left: 8, right: 8),
                            child: Row(
                              children: [
                                Text(
                                  '$sets sets',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '$reps reps',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 8, left: 8, right: 8),
                            child: Text(
                              '$minRests minutes rest',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            '../lib/images/Pull_Person.png',
                            height: 80,
                            width: 100,
                          )
                        ],
                      ),

                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            onPressed: () {},
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                              child: Container(
                                height: 30,
                                width: 50,
                                color: const Color(0xFF9AB8F9),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Text('Edit'),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          MaterialButton(
                            onPressed: () {},
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                              child: Container(
                                  height: 30,
                                  width: 50,
                                  color: const Color(0xFF9AB8F9),
                                  child: const Align(
                                      alignment: Alignment.center,
                                      child: Text('Delete'))),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  color: const Color(0xFF9AB8F9),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 200.0),
                        child: Text(
                          'Legs',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                          icon: const Icon(Icons.add_box_outlined),
                          iconSize: 30.0,
                          onPressed: () {
                            exeNumber += 1;
                          }),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  color: const Color(0xfffbfbad),
                  height: 100.0,
                  child: Row(
                    children: [
                      // First Column
                      Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Exercise: $exeNumber',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 8, left: 8, right: 8),
                            child: Row(
                              children: [
                                Text(
                                  '$sets sets',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '$reps reps',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 8, left: 8, right: 8),
                            child: Text(
                              '$minRests minutes rest',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            '../lib/images/Legs_Person.png',
                            height: 80,
                            width: 100,
                          )
                        ],
                      ),

                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                              onPressed: () {},
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                child: Container(
                                    height: 30,
                                    width: 50,
                                    color: const Color(0xFF9AB8F9),
                                    child: const Align(
                                        alignment: Alignment.center,
                                        child: Text('Edit'))),
                              )),
                          const SizedBox(height: 10),
                          MaterialButton(
                              onPressed: () {},
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                child: Container(
                                    height: 30,
                                    width: 50,
                                    color: const Color(0xFF9AB8F9),
                                    child: const Align(
                                        alignment: Alignment.center,
                                        child: Text('Delete'))),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  color: const Color(0xfffbfbad),
                  height: 100.0,
                  child: Row(
                    children: [
                      // First Column
                      Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Exercise: $exeNumber',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 8, left: 8, right: 8),
                            child: Row(
                              children: [
                                Text(
                                  '$sets sets',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '$reps reps',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 8, left: 8, right: 8),
                            child: Text(
                              '$minRests minutes rest',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            '../lib/images/Legs_Person.png',
                            height: 80,
                            width: 100,
                          )
                        ],
                      ),

                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                              onPressed: () {},
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                child: Container(
                                    height: 30,
                                    width: 50,
                                    color: const Color(0xFF9AB8F9),
                                    child: const Align(
                                        alignment: Alignment.center,
                                        child: Text('Edit'))),
                              )),
                          const SizedBox(height: 10),
                          MaterialButton(
                              onPressed: () {},
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                child: Container(
                                    height: 30,
                                    width: 50,
                                    color: const Color(0xFF9AB8F9),
                                    child: const Align(
                                        alignment: Alignment.center,
                                        child: Text('Delete'))),
                              )),
                        ],
                      ),
                    ],
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
