import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController userEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRepeatController = TextEditingController();

  Padding _signInButton({
    required Function onPressedCallback,
    required String imagePath,
    required String buttonText,
    required Color buttonColor,
    required Color textColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 4,
        bottom: 4,
      ),
      child: MaterialButton(
        onPressed: () {
          onPressedCallback();
        },
        shape: const OutlineInputBorder(),
        color: buttonColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  imagePath,
                  height: 30,
                  width: 30,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 3,
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Image.asset(
                  '../lib/images/Fitser_Logo.png',
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(1.0),
                child: Text(
                  'Fitser',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(1.0),
                child: Text(
                  'Workout Planner and Tracker',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 5,
                  ),
                  child: Text(
                    'Please Enter Your Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: userEmailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: HexColor('#FBFBAD'),
                    hintText: 'JoeMama@gmail.com',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Expanded(
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: HexColor('#FBFBAD'),
                    hintText: 'Enter Your Password',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Expanded(
                child: TextField(
                  controller: passwordRepeatController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: HexColor('#FBFBAD'),
                    hintText: 'Repeat Your Password',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Expanded(
                child: _signInButton(
                  onPressedCallback: () async {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: userEmailController.text,
                        password: passwordController.text,
                      );
                      print('user created');
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  imagePath: '../lib/images/G_Logo.png',
                  buttonText: 'Sign Up',
                  buttonColor: Colors.white,
                  textColor: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Text(
                  'Already Have an Account?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: _signInButton(
                  onPressedCallback: () {},
                  imagePath: '../lib/images/G_Logo.png',
                  buttonText: 'Login',
                  buttonColor: Colors.white,
                  textColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
