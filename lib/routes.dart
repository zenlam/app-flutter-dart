import 'package:flutter/widgets.dart';
import 'package:pivotino_flutter_app/screens/auth/login/login_screen.dart';
import 'package:pivotino_flutter_app/screens/auth/reset_password/reset_password_screen.dart';
import 'package:pivotino_flutter_app/screens/home/home_screen.dart';
import 'package:pivotino_flutter_app/screens/profile/change_password_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ChangePasswordScreen.routeName: (context) => ChangePasswordScreen(),
};
