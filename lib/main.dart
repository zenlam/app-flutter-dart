import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pivotino_flutter_app/routes.dart';
import 'package:pivotino_flutter_app/screens/auth/login/login_screen.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: kPivotinoPrimary,
      systemNavigationBarColor: kPivotinoPrimary,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pivotino',
      initialRoute: LoginScreen.routeName,
      routes: routes,
    );
  }
}
