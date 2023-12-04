import 'package:fast_snackbar/fast_snackbar.dart';
import 'package:fitster/component_widgets/form_elements.dart';
import 'package:fitster/services/auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';

MyTextFormField emailField = MyTextFormField(
  validatorCallback: (value) {
    if (RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]+$').hasMatch(value!)) {
      return null;
    } else {
      return '';
    }
  },
  hintText: 'JoeMama@gmail.com',
  prefixIcon: Icons.email,
);
MyTextFormField passwordField = MyTextFormField(
  validatorCallback: (value) {
    if (value == null || value.isEmpty) {
      return '';
    }
    return null;
  },
  hintText: 'Enter Your Password',
  prefixIcon: Icons.lock,
  obscureText: true,
);
MyTextFormField passwordRepeatField = MyTextFormField(
  validatorCallback: (value) {
    if (value == null || value.isEmpty || value != passwordField.getText()) {
      return '';
    }
    return null;
  },
  hintText: 'Repeat Your Password',
  prefixIcon: Icons.lock,
  obscureText: true,
);

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
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
              Divider(
                thickness: 2,
                color: HexColor('#9AB8F9'),
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
              Expanded(child: emailField),
              const Gap(3),
              Expanded(child: passwordField),
              const Gap(3),
              Expanded(child: passwordRepeatField),
              const Gap(3),
              Expanded(
                child: MyInputButton(
                  onPressedCallback: () async {
                    if (_formKey.currentState!.validate()) {
                      signUpWithEmail(
                        email: emailField.getText(),
                        password: passwordField.getText(),
                      ).then((value) {
                        if (value == 'The password provided is too weak') {
                          context.showFastSnackbar(
                            'password is too weak',
                            color: TypeFastSnackbar.warning,
                          );
                        }
                        if (value ==
                            'The account already exists for that email') {
                          context.showFastSnackbar(
                            'account already exists',
                            color: TypeFastSnackbar.warning,
                          );
                        }
                        if (value == 'sign up failed') {
                          context.showFastSnackbar(
                            'Sign Up failed',
                            color: TypeFastSnackbar.error,
                          );
                        }
                        if (value == 'user created') {
                          context.showFastSnackbar(
                            'Sign Up Successful',
                            color: TypeFastSnackbar.success,
                          );
                        }
                      });
                    } else {
                      context.showFastSnackbar(
                        'Enter Correct email format or check if both passwords are the same',
                        color: TypeFastSnackbar.error,
                      );
                    }
                  },
                  imagePath: '../lib/images/G_Logo.png',
                  buttonText: 'Sign Up',
                  buttonColor: Colors.white,
                  textColor: Colors.black,
                  imageAlignment: Alignment.centerRight,
                  flex: 1,
                ),
              ),
              const Gap(20),
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
                child: MyInputButton(
                  onPressedCallback: () {
                    Navigator.pop(context);
                  },
                  imagePath: '../lib/images/G_Logo.png',
                  buttonText: 'Go Back To Login Screen',
                  buttonColor: Colors.white,
                  textColor: Colors.black,
                  imageAlignment: Alignment.centerRight,
                  flex: 2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
