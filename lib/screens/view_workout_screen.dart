import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitster/services/db_operations.dart';
import 'package:flutter/material.dart';
import 'package:async_builder/async_builder.dart';

Padding groupIndicator({
  required String groupName,
  required Function onAdd,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color(0xFF9AB8F9),
      ),
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              groupName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_box_outlined),
              iconSize: 30.0,
              onPressed: () {
                onAdd();
              },
            ),
          ],
        ),
      ),
    ),
  );
}

Padding exerciseCard({
  required String exerciseName,
  required String setNumber,
  required String repNumber,
  required String restTime,
  required Function onEdit,
  required Function onDelete,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: const BoxDecoration(
        color: Color(0xfffbfbad),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      height: 105.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    exerciseName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$setNumber sets',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '$repNumber reps',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '$restTime seconds rest',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Image.asset(
                '../lib/images/Push_Person.png',
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      onEdit();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF9AB8F9),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      height: 30,
                      width: 50,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text('Edit'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MaterialButton(
                    onPressed: () {
                      onDelete();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF9AB8F9),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      height: 30,
                      width: 50,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text('Delete'),
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
  );
}

class MuscleGroupSection extends StatefulWidget {
  const MuscleGroupSection({super.key, required this.data});
  // data passed here is an object from a list
  final Map<String, dynamic> data;
  @override
  State<MuscleGroupSection> createState() => _MuscleGroupSectionState();
}

class _MuscleGroupSectionState extends State<MuscleGroupSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        groupIndicator(
          groupName: widget.data['group'],
          onAdd: () {},
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.data['exercises'].length,
          itemBuilder: (context, index) {
            return exerciseCard(
              exerciseName: widget.data['exercises'][index]['name'] as String,
              setNumber: widget.data['exercises'][index]['sets'].toString(),
              repNumber: widget.data['exercises'][index]['reps'].toString(),
              restTime: widget.data['exercises'][index]['rest_time'].toString(),
              onEdit: () {},
              onDelete: () {},
            );
          },
        )
      ],
    );
  }
}

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
      body: AsyncBuilder(
        future:
            getMuscleGroupById(docId: FirebaseAuth.instance.currentUser?.uid),
        builder: (context, value) {
          return SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: value?.length,
              itemBuilder: (context, index) {
                return MuscleGroupSection(data: value?[index]);
              },
            ),
          );
        },
        waiting: (context) => const Text('Loading...'),
        error: (context, error, stackTrace) => Text('Error! $error'),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SingleChildScrollView(
  //       physics: const ScrollPhysics(),
  //       child: Column(
  //         children: [
  //           MuscleGroupSection(data: test),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
