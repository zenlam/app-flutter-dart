import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class IncorrectEmailFormat extends StatelessWidget {
  final String errTitle = "Invalid email address";
  final String errMessage =
      "Sorry, email address is not recognizable. Please try again.";

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Text(
          errTitle,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        content: Text(
          errMessage,
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(
              'Try again',
              style: TextStyle(
                color: kDialogTextBlue,
                fontSize: 17.0,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: Text(
          errTitle,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        content: Text(
          errMessage,
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              'Try again',
              style: TextStyle(
                color: kDialogTextBlue,
                fontSize: 17.0,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    }
  }
}
