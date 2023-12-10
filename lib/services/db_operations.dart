import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitster/models/workout_splits.dart';
import 'package:fitster/services/helper_functions.dart';
import 'package:fitster/services/workout_plan_builder.dart';

Future<void> addSplitToFirestore({
  required String? docId,
  required Map<String, dynamic> jsonData,
}) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc(docId);
  await docUser.set(jsonData);
}

Future<void> addUserInformationToFirestore({
  required String? docId,
  required Map<String, dynamic> jsonData,
}) async {
  final docUser =
      FirebaseFirestore.instance.collection('user_information').doc(docId);
  await docUser.set(jsonData);
}

Future<List<dynamic>> getMuscleGroupById({required String? docId}) async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');
  DocumentSnapshot documentSnapshot =
      await collectionReference.doc(docId).get();
  if (documentSnapshot.exists) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return data['muscle_group'];
  } else {
    return [];
  }
}

Stream<DocumentSnapshot<Map<String, dynamic>>> getMuscleGroupStream(
    {required String? docId}) {
  return FirebaseFirestore.instance.collection('users').doc(docId).snapshots();
}

Future<void> updateExerciseDates({
  required String? docId,
  required Map<String, dynamic> jsonData,
}) async {
  final docUser =
      FirebaseFirestore.instance.collection('workout_tracking').doc(docId);
  await docUser.set(jsonData);
}

Future<List<dynamic>> getDaysExercised({required String? docId}) async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('workout_tracking');
  DocumentSnapshot documentSnapshot =
      await collectionReference.doc(docId).get();
  if (documentSnapshot.exists) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return data['days_exercised'];
  } else {
    return [];
  }
}

Map<int, Map<String, int>> repeatVolumeBySchedule(
  Map<int, Map<String, int>> data,
) {
  Map<int, Map<String, int>> myData = data;
  List<Map<String, int>> pointer = [];
  bool hasIterated = false;
  bool zeroPoint = false;
  int counter = 0;

  for (var i = 0; i < myData.keys.length; i++) {
    if (myData[i]?['reps'] as int != 0 && !hasIterated) {
      pointer.add(myData[i]!);
    }
    if (myData[i]?['reps'] as int == 0 && !zeroPoint) {
      hasIterated = true;
      zeroPoint = true;
      continue;
    }
    if (zeroPoint) {
      myData.update(i, (value) => pointer[counter]);
      counter++;
      if (counter == pointer.length) {
        counter = 0;
        zeroPoint = false;
      }
    }
  }

  return myData;
}

Future<Map<String, int>> getTrainingVolume({required String? docId}) async {
  Map<int, Map<String, int>> trainingVolume = {
    0: {
      'reps': 0,
      'sets': 0,
    },
    1: {
      'reps': 0,
      'sets': 0,
    },
    2: {
      'reps': 0,
      'sets': 0,
    },
    3: {
      'reps': 0,
      'sets': 0,
    },
    4: {
      'reps': 0,
      'sets': 0,
    },
    5: {
      'reps': 0,
      'sets': 0,
    },
    6: {
      'reps': 0,
      'sets': 0,
    }
  };
  List<dynamic> muscleGroups = await getMuscleGroupById(docId: docId);
  if (muscleGroups.isNotEmpty) {
    for (var i = 0; i < muscleGroups.length; i++) {
      int totalReps = 0;
      int totalSets = 0;
      for (var x = 0; x < muscleGroups[i]['exercises'].length; x++) {
        totalReps += muscleGroups[i]['exercises'][x]['sets'] as int;
        totalSets += muscleGroups[i]['exercises'][x]['reps'] as int;
      }
      trainingVolume.update(
          i,
          (value) => {
                'reps': totalReps,
                'sets': totalSets,
              });
    }
    trainingVolume = repeatVolumeBySchedule(trainingVolume);
  }
  return trainingVolume[DateTime.now().weekday - 1] as Map<String, int>;
}

Future<List<dynamic>> getTargetMuscles({required String? docId}) async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');
  DocumentSnapshot documentSnapshot =
      await collectionReference.doc(docId).get();
  if (documentSnapshot.exists) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return data['workout_split']['target_muscles'];
  } else {
    return [];
  }
}

Future<Map<String, dynamic>> getUserInformation(
    {required String? docId}) async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('user_information');
  DocumentSnapshot documentSnapshot =
      await collectionReference.doc(docId).get();
  if (documentSnapshot.exists) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return data;
  } else {
    return {
      'weight': '0',
      'fitness_level': 'none',
      'age': 0,
      'height': '0',
      'fitness_goals': 'none',
      'weekly_burned_calories': {
        'monday': 0,
        'tuesday': 0,
        'wednesday': 0,
        'thursday': 0,
        'friday': 0,
        'saturday': 0,
        'sunday': 0,
      },
    };
  }
}

Future<void> createNewWorkoutSplit({
  required String? docId,
  required String selectedSplit,
  required String fitnessLevel,
  required String fitnessGoal,
  required String age,
  required String height,
  required String weight,
}) async {
  switch (selectedSplit) {
    case 'Bro Split':
      selectedSplit = 'bro_split';
      break;
    case 'Push-Pull-Legs':
      selectedSplit = 'push_pull_legs';
      break;
    case 'Upper-Lower':
      selectedSplit = 'upper_lower';
      break;
    default:
      selectedSplit = 'no split';
  }
  WorkoutSplit mySplit = await createWorkoutPlan(selectedSplit);
  await addSplitToFirestore(
    docId: docId,
    jsonData: mySplit.toJson(),
  );
  await addUserInformationToFirestore(
    docId: docId,
    jsonData: {
      'fitness_level': fitnessLevel,
      'fitness_goals': fitnessGoal,
      'age': age,
      'height': height,
      'weight': weight,
    },
  );
}

Future<void> addNewExercise({
  required String? docId,
  required String exerciseName,
  required String reps,
  required String sets,
  required String restTime,
  required String targetGroup,
}) async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');
  DocumentReference documentReference = collectionReference.doc(docId);
  DocumentSnapshot documentSnapshot = await documentReference.get();
  if (documentSnapshot.exists) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    for (var groupName in data['muscle_group']) {
      if (groupName['group'] == targetGroup) {
        groupName['exercises'].add({
          'sets': int.parse(sets),
          'reps': int.parse(reps),
          'rest_time': int.parse(restTime),
          'name': exerciseName,
        });
        break;
      }
    }
    documentReference.update({
      'muscle_group': data['muscle_group'],
    });
  }
}

Future<void> deleteExercise({
  required String? docId,
  required String targetGroup,
  required int index,
}) async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');
  DocumentReference documentReference = collectionReference.doc(docId);
  DocumentSnapshot documentSnapshot = await documentReference.get();
  if (documentSnapshot.exists) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    for (var group in data['muscle_group']) {
      if (group['group'] == targetGroup) {
        group['exercises'].removeAt(index);
        break;
      }
    }
    documentReference.update({
      'muscle_group': data['muscle_group'],
    });
  }
}

Future<void> editExercise({
  required String? docId,
  required String exerciseName,
  required String reps,
  required String sets,
  required String restTime,
  required String targetGroup,
  required int index,
}) async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');
  DocumentReference documentReference = collectionReference.doc(docId);
  DocumentSnapshot documentSnapshot = await documentReference.get();
  if (documentSnapshot.exists) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    for (var groupName in data['muscle_group']) {
      if (groupName['group'] == targetGroup) {
        groupName['exercises'][index] = {
          'sets': int.parse(sets),
          'reps': int.parse(reps),
          'rest_time': int.parse(restTime),
          'name': exerciseName,
        };
        break;
      }
    }
    documentReference.update({
      'muscle_group': data['muscle_group'],
    });
  }
}

Future<String> getCurrentMuscleGroup({
  required String? docId,
}) async {
  List<dynamic> muscleGroups = await getMuscleGroupById(docId: docId);
  List<String> groups = [];
  int counter = 0;
  if (muscleGroups.isNotEmpty) {
    for (var i = 0; i < 7; i++) {
      if (counter < muscleGroups.length) {
        groups.add(muscleGroups[counter]['group']);
        counter++;
      } else {
        groups.add('');
        counter = 0;
      }
    }
    return (groups[DateTime.now().weekday - 1]);
  } else {
    return '';
  }
}

Future<void> addCaloriesBurned({
  required String? docId,
  required int totalReps,
  required String exerciseName,
}) async {
  CollectionReference colReference =
      FirebaseFirestore.instance.collection('burned_calories');
  DocumentReference docReference = colReference.doc(docId);
  DocumentSnapshot docSnapshot = await docReference.get();

  double caloriesBurned = totalCaloriesBurned(
    totalReps: totalReps,
    weight: double.parse('70'),
  );

  DateTime timeNow = DateTime.now();

  String currentDate = '${timeNow.year}-${timeNow.month}-${timeNow.day}';

  if (docSnapshot.exists) {
    Map<dynamic, dynamic> data = docSnapshot.data() as Map<dynamic, dynamic>;
    if (data.containsKey(currentDate)) {
      if (!data[currentDate]['exercises'].contains(exerciseName)) {
        data[currentDate]['exercises'].add(exerciseName);
        data[currentDate]['calories_burned'] += caloriesBurned;
      } else {
        data[currentDate]['exercises'].remove(exerciseName);
        data[currentDate]['calories_burned'] -= caloriesBurned;
      }
    }
    docReference.update({
      currentDate: data[currentDate],
    });
  } else {
    docReference.set(
      {
        currentDate.toString(): {
          'calories_burned': caloriesBurned,
          'exercises': [exerciseName],
        }
      },
    );
  }
}

Future<bool> isExerciseFinished({
  required String? docId,
  required String exerciseName,
}) async {
  CollectionReference colReference =
      FirebaseFirestore.instance.collection('burned_calories');
  DocumentReference docReference = colReference.doc(docId);
  DocumentSnapshot docSnapshot = await docReference.get();
  DateTime timeNow = DateTime.now();

  String currentDate = '${timeNow.year}-${timeNow.month}-${timeNow.day}';

  if (docSnapshot.exists) {
    Map<dynamic, dynamic> data = docSnapshot.data() as Map<dynamic, dynamic>;
    if (data.containsKey(currentDate)) {
      return data[currentDate]['exercises'].contains(exerciseName);
    }
  }
  return false;
}

Future<Map<String, dynamic>> getCaloriesBurnedThisWeek({
  required String? docId,
}) async {
  CollectionReference colReference =
      FirebaseFirestore.instance.collection('burned_calories');
  DocumentReference docReference = colReference.doc(docId);
  DocumentSnapshot docSnapshot = await docReference.get();

  Map<String, dynamic> weeklyBurnedCalories = {
    '1': 0,
    '2': 0,
    '3': 0,
    '4': 0,
    '5': 0,
    '6': 0,
    '7': 0,
  };

  if (docSnapshot.exists) {
    List<String> currentWeek = getCurrentWeek();
    Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    for (String date in data.keys.toList()) {
      if (currentWeek.contains(date)) {
        int weekDate = DateTime.parse(formatDateString(date)).weekday;
        weeklyBurnedCalories[weekDate.toString()] =
            data[date]['calories_burned'];
      }
    }
  }
  return weeklyBurnedCalories;
}

Future<void> deleteWorkoutPlan({
  required String? docId,
}) async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');
  DocumentReference documentReference = collectionReference.doc(docId);
  DocumentSnapshot documentSnapshot = await documentReference.get();
  if (documentSnapshot.exists) {
    documentReference.delete();
  }
}
