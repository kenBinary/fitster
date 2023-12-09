import 'package:fast_snackbar/fast_snackbar.dart';
import 'package:fitster/component_widgets/form_elements.dart';
import 'package:fitster/screens/sign_up_screen.dart';
import 'package:fitster/services/auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final MyTextField emailInputField = MyTextField(
    hintText: 'Enter Your Email',
    prefixIcon: Icons.person,
  );

  final MyTextField passwordInputField = MyTextField(
    hintText: 'Enter Your Password',
    prefixIcon: Icons.lock,
    obscureText: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Image.asset('assets/images/fitster-icon.png'),
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
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
            Expanded(child: emailInputField),
            const Gap(3),
            Expanded(child: passwordInputField),
            const Gap(3),
            Expanded(
              child: MyInputButton(
                onPressedCallback: () {
                  loginWithEmail(
                    email: emailInputField.getText(),
                    password: passwordInputField.getText(),
                  ).then((value) {
                    if (value == 'login success') {
                      Navigator.pushNamed(context, '/main');
                    } else {
                      context.showFastSnackbar(
                        value,
                        color: TypeFastSnackbar.error,
                      );
                    }
                  });
                },
                imagePath: 'assets/images/email-logo.png',
                buttonText: 'Sign In With Email',
                buttonColor: Colors.white,
                textColor: Colors.black,
              ),
            ),
            const Gap(20),
            Expanded(
              child: MyInputButton(
                onPressedCallback: () {},
                imagePath: 'assets/images/google-logo.png',
                buttonText: 'Sign In With Google',
                buttonColor: Colors.white,
                textColor: Colors.black,
              ),
            ),
            Expanded(
              child: MyInputButton(
                onPressedCallback: () {},
                imagePath: 'assets/images/x-logo.png',
                buttonText: 'Sign In With Twitter',
                buttonColor: Colors.black,
                textColor: Colors.white,
              ),
            ),
            Expanded(
              child: MyInputButton(
                onPressedCallback: () {},
                imagePath: 'assets/images/github-logo.png',
                buttonText: 'Sign In With GitHub',
                buttonColor: Colors.white,
                textColor: Colors.black,
              ),
            ),
            Expanded(
              child: MyInputButton(
                onPressedCallback: () {},
                imagePath: 'assets/images/facebook-logo.png',
                buttonText: 'Sign In With Facebook',
                buttonColor: Colors.blueAccent,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
