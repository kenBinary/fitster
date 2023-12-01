import 'package:fitster/services/auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: HexColor('#9AB8F9'),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TextField(
                  controller: userEmailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: HexColor('#FBFBAD'),
                    hintText: 'Enter Your Email',
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
              Expanded(
                child: _signInButton(
                  onPressedCallback: () async {
                    String test = await loginWithEmail(
                      email: userEmailController.text,
                      password: passwordController.text,
                    );
                    if (test == 'login success' && mounted) {
                      Navigator.pushNamed(context, '/main');
                    }
                  },
                  imagePath: '../lib/images/G_Logo.png',
                  buttonText: 'Sign In With Email',
                  buttonColor: Colors.white,
                  textColor: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: _signInButton(
                  onPressedCallback: () {},
                  imagePath: '../lib/images/G_Logo.png',
                  buttonText: 'Sign In With Google',
                  buttonColor: Colors.white,
                  textColor: Colors.black,
                ),
              ),
              Expanded(
                child: _signInButton(
                  onPressedCallback: () {},
                  imagePath: '../lib/images/X_Logo.png',
                  buttonText: 'Sign In With Twitter',
                  buttonColor: Colors.black,
                  textColor: Colors.white,
                ),
              ),
              Expanded(
                child: _signInButton(
                  onPressedCallback: () {},
                  imagePath: '../lib/images/E_Logo.png',
                  buttonText: 'Sign In With GitHub',
                  buttonColor: Colors.white,
                  textColor: Colors.black,
                ),
              ),
              Expanded(
                child: _signInButton(
                  onPressedCallback: () {},
                  imagePath: '../lib/images/F_Logo.png',
                  buttonText: 'Sign In With Facebook',
                  buttonColor: Colors.blueAccent,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
