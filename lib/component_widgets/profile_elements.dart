import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class VitalCards extends StatelessWidget {
  const VitalCards({
    super.key,
    required this.vitalType,
    required this.vitalValue,
  });

  final String vitalType;
  final String vitalValue;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: BeveledRectangleBorder(
        side: BorderSide(
          color: HexColor('#9AB8F9'),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                vitalType,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              vitalValue,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
