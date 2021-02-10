import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pivotino_flutter_app/screens/auth/login/components/login_form.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = "/pivotino/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      body: Platform.isIOS
          ? AnnotatedRegion(
              value: SystemUiOverlayStyle.dark,
              child: buildSafeArea(),
            )
          : buildSafeArea(),
    );
  }

  SafeArea buildSafeArea() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Column(
          children: [
            SizedBox(height: 50.0),
            Image.asset('assets/images/pivotino_logo.png'),
            SizedBox(height: 40.0),
            Expanded(
              child: LoginForm(),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
