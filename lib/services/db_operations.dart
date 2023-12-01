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
