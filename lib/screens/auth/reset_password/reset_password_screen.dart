import 'package:flutter/material.dart';
import 'package:pivotino_flutter_app/screens/auth/reset_password/components/reset_form.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class ResetPasswordScreen extends StatelessWidget {
  static String routeName = "/pivotino/reset/password";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.0),
              Container(
                alignment: Alignment.center,
                child: Image.asset('assets/images/pivotino_logo.png'),
              ),
              SizedBox(height: 40.0),
              Text(
                'Reset your password',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: kFontDarkBlue,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                "Please enter the email address and we'll send you a link to reset your password.",
                style: TextStyle(
                  fontSize: 17.0,
                  color: kFontDarkBlue,
                ),
              ),
              SizedBox(height: 32.0),
              Expanded(
                child: ResetPasswordForm(),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
