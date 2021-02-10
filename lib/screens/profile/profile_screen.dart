import 'package:flutter/material.dart';
import 'package:pivotino_flutter_app/screens/auth/login/login_screen.dart';
import 'package:pivotino_flutter_app/screens/profile/components/profile_body.dart';
import 'package:pivotino_flutter_app/services/storage.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class ProfileScreen extends StatelessWidget {
  final SecureStorage secureStorage = SecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0),
        child: AppBar(
          elevation: 1.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          title: Text(
            'Profile',
            style: TextStyle(
              color: kFontDarkBlue,
              fontSize: 17.0,
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                secureStorage.deleteSecureData('token');
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              child: Text(
                'Log out',
                style: TextStyle(
                  color: kFontRed,
                  fontWeight: FontWeight.normal,
                ),
              ),
            )
          ],
        ),
      ),
      body: ProfileBody(),
    );
  }
}
