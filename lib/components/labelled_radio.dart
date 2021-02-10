import 'package:flutter/material.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class LabelelRadio extends StatelessWidget {
  final String label;
  final int groupValue;
  final int value;
  final Function onChanged;

  const LabelelRadio({
    this.label,
    this.groupValue,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: SizedBox(
        height: 28.0,
        child: Row(
          children: [
            SizedBox(
              width: 24.0,
              child: Radio(
                activeColor: kRadioActiveGreen,
                value: value,
                groupValue: groupValue,
                onChanged: (int value) {
                  onChanged(value);
                },
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              label,
              style: TextStyle(
                color: kFontDarkBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
