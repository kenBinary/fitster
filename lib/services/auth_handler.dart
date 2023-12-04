import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSignOut() async {
  await FirebaseAuth.instance.signOut();
}

Future<String> loginWithEmail({
  required String email,
  required String password,
}) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return 'login success';
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 'No user found';
      // print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      return 'Wrong password';
      // print('Wrong password provided for that user.');
    }
  }
  return 'login failed';
}

Future<String> signUpWithEmail({
  required String email,
  required String password,
}) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return 'user created';
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email';
    }
  } catch (e) {
    return e.toString();
  }
  return 'sign up failed';
}
