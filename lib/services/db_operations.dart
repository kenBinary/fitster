import 'package:cloud_firestore/cloud_firestore.dart';

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
    Map<int, Map<String, int>> data) {
  Map<int, Map<String, int>> myData = data;
  List<Map<String, int>> pointer = [];
  bool hasIterated = false;
  bool zeroPoint = false;
  int counter = 0;

  for (var i = 0; i < myData.keys.length; i++) {
    // data[i] == value
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

  return trainingVolume[DateTime.now().weekday - 1] as Map<String, int>;
}

Future<List<dynamic>> getTargetMuscles({required String? docId}) async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');
  DocumentSnapshot documentSnapshot =
      await collectionReference.doc(docId).get();
  // print(data['workout_split']['target_muscles']);
  if (documentSnapshot.exists) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return data['workout_split']['target_muscles'];
  } else {
    return [];
  }
}
