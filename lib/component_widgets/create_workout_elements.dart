import 'package:flutter/material.dart';

class FitnessLevelButton extends StatelessWidget {
  const FitnessLevelButton({
    super.key,
    required this.selectedButton,
    required this.text,
    required this.setFitnessLevel,
  });

  final String selectedButton;
  final String text;
  final Function setFitnessLevel;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        setFitnessLevel();
      },
      color: (selectedButton == text) ? const Color(0xfffbfbad) : Colors.white,
      minWidth: 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13),
      ),
    );
  }
}

class SplitSelectorButton extends StatelessWidget {
  const SplitSelectorButton({
    super.key,
    required this.imagePath,
    required this.text,
    required this.setSelectedSplit,
    required this.selectedSplit,
  });
  final String imagePath;
  final String text;
  final Function setSelectedSplit;
  final String selectedSplit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: () {
            setSelectedSplit();
          },
          child: Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              // color: Color(0xFF9AB8F9),
              color: (selectedSplit == text)
                  ? const Color(0xfffbfbad)
                  : const Color(0xFF9AB8F9),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                imagePath,
                height: 40.0,
                width: 40.0,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(text),
      ],
    );
  }
}

class InputLabel extends StatelessWidget {
  const InputLabel({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
