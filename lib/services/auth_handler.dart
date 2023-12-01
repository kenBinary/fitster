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
