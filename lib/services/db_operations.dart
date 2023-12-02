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
