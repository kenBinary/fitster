import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController textFieldController = TextEditingController();

  MyTextFormField({
    super.key,
    required this.validatorCallback,
    required this.hintText,
    this.prefixIcon,
    this.obscureText,
  });
  final String? Function(String?)? validatorCallback;
  final String hintText;
  final IconData? prefixIcon;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validatorCallback,
      controller: textFieldController,
      obscureText: (obscureText == null) ? false : true,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        prefixIcon: (prefixIcon == null) ? null : Icon(prefixIcon),
        errorStyle: const TextStyle(
          height: 0,
          color: Colors.transparent,
          fontSize: 0,
        ),
        filled: true,
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }

  String getText() {
    return textFieldController.text;
  }
}

class MyTextField extends StatelessWidget {
  MyTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.obscureText,
  });

  final TextEditingController textFieldController = TextEditingController();
  final String hintText;
  final IconData? prefixIcon;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textFieldController,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      obscureText: (obscureText == null) ? false : true,
      decoration: InputDecoration(
        filled: true,
        hintText: 'Enter Your Email',
        border: const OutlineInputBorder(),
        prefixIcon: (prefixIcon == null) ? null : Icon(prefixIcon),
      ),
    );
  }

  String getText() {
    return textFieldController.text;
  }
}

class MyInputButton extends StatelessWidget {
  const MyInputButton({
    super.key,
    required this.onPressedCallback,
    required this.imagePath,
    required this.buttonText,
    required this.buttonColor,
    required this.textColor,
    this.imageAlignment = Alignment.center,
    this.flex = 2,
  });

  final Function onPressedCallback;
  final String imagePath;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final AlignmentGeometry imageAlignment;
  final int flex;

  @override
  Widget build(BuildContext context) {
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
          children: [
            Expanded(
              child: Align(
                alignment: imageAlignment,
                child: Image.asset(
                  imagePath,
                  height: 30,
                  width: 30,
                ),
              ),
            ),
            const Gap(10),
            Expanded(
              flex: flex,
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
}
