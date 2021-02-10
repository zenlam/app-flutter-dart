import 'package:flutter/material.dart';
import 'package:pivotino_flutter_app/screens/profile/components/change_password_form.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class ChangePasswordScreen extends StatelessWidget {
  static String routeName = "/change/password";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0),
        child: AppBar(
          elevation: 1.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          leadingWidth: 80.0,
          leading: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                color: kFontBlueGrey,
                fontSize: 15.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          title: Text(
            'Change Password',
            style: TextStyle(
              color: kFontDarkBlue,
              fontSize: 17.0,
            ),
          ),
        ),
      ),
      body: ChangePasswordForm(),
    );
  }
}
