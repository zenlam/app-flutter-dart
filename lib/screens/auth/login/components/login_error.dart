import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pivotino_flutter_app/screens/auth/reset_password/reset_password_screen.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class IncorrectPassword extends StatelessWidget {
  final String errTitle = "Incorrect Password";
  final String errMessage =
      "The password you entered is incorrect. Please try again.";

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
          Column(
            children: [
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
              Divider(
                height: 1.0,
                color: Colors.black87,
              ),
              CupertinoDialogAction(
                child: Text(
                  'Forgot password',
                  style: TextStyle(
                    color: kDialogTextBlue,
                    fontSize: 17.0,
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, ResetPasswordScreen.routeName);
                },
              ),
            ],
          )
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
          FlatButton(
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
          )
        ],
      );
    }
  }
}
