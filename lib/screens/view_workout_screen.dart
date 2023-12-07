import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitster/component_widgets/view_workout_elements.dart';
import 'package:fitster/services/db_operations.dart';
import 'package:flutter/material.dart';
import 'package:async_builder/async_builder.dart';

class ViewWorkout extends StatelessWidget {
  const ViewWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AsyncBuilder(
        stream:
            getMuscleGroupStream(docId: FirebaseAuth.instance.currentUser?.uid),
        waiting: (context) => const Text('Loading...'),
        builder: (context, snapshot) {
          Map<String, dynamic>? data = snapshot?.data();
          return SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: (data != null && data.containsKey('muscle_group')
                  ? data['muscle_group'].length
                  : 1),
              itemBuilder: (context, index) {
                if (data == null) {
                  return const Text('no created workout plan');
                }
                return MuscleGroupSection(
                  data: data['muscle_group'][index],
                );
              },
            ),
          );
        },
        error: (context, error, stackTrace) => Text('Error! $error'),
        closed: (context, value) => Text('$value (closed)'),
      ),
    );
  }
}
