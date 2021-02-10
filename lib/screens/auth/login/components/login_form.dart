import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:pivotino_flutter_app/components/common_error.dart';
import 'package:pivotino_flutter_app/screens/auth/login/components/login_error.dart';
import 'package:pivotino_flutter_app/screens/auth/reset_password/reset_password_screen.dart';
import 'package:pivotino_flutter_app/screens/home/home_screen.dart';
import 'package:pivotino_flutter_app/services/rest_api_service.dart';
import 'package:pivotino_flutter_app/services/storage.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final SecureStorage secureStorage = SecureStorage();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obsurePassword = true;
  bool _disableLogin = true;

  Future login(String email) async {
    if (!EmailValidator.validate(email)) {
      return showDialog(
        context: context,
        builder: (context) {
          return IncorrectEmailFormat();
        },
      );
    }

    var response = await getInstanceData(loginEmail: email);

    if (response.statusCode == 200) {
      // decode the response body
      var decodedJson = jsonDecode(response.body);

      // get the data from the decoded body
      var data = decodedJson['data'][0];

      // write the data into secured storage
      secureStorage.writeSecureData('instance_url', data['instance_url']);
      secureStorage.writeSecureData('login', _emailController.text.trim());
      secureStorage.writeSecureData(
        'password',
        _passwordController.text.trim(),
      );
      secureStorage.writeSecureData('db_name', data['db_name']);

      try {
        await getAuthenticationToken();
      } catch (e) {
        return showDialog(
          context: context,
          builder: (context) {
            return IncorrectPassword();
          },
        );
      }

      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else if (response.statusCode == 401) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Invalid Access"),
            content: Text("Invalid Login"),
          );
        },
      );
    } else {
      print('unknown error maybe');
    }
  }

  void isEmpty() {
    setState(() {
      if (_emailController.text.trim() != "" &&
          _passwordController.text.trim() != "") {
        _disableLogin = false;
      } else {
        _disableLogin = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            onChanged: (value) {
              isEmpty();
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: "Email Address",
              labelStyle: TextStyle(fontSize: 14.0),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[200]),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[200]),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: _passwordController,
            onChanged: (value) {
              isEmpty();
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: "Password",
              labelStyle: TextStyle(fontSize: 14.0),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[200]),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[200]),
              ),
              suffixIcon: SizedBox(
                child: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye_outlined,
                    size: 24.0,
                    color: _obsurePassword ? Colors.grey : Colors.blue,
                  ),
                  onPressed: () {
                    setState(() {
                      _obsurePassword = !_obsurePassword;
                    });
                  },
                ),
              ),
            ),
            obscureText: _obsurePassword,
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, ResetPasswordScreen.routeName);
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    color:
                        _disableLogin ? Colors.grey[300] : kPivotinoSecondary,
                    textColor: _disableLogin ? Colors.grey[400] : Colors.black,
                    padding: EdgeInsets.all(8.0),
                    minWidth: double.infinity,
                    height: 44.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onPressed: () {
                      if (!_disableLogin) {
                        login(_emailController.text.trim());
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          height: 40,
                          thickness: 1,
                          color: Colors.grey[400],
                          endIndent: 16.0,
                        ),
                      ),
                      Text(
                        'or',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16.0,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          height: 40,
                          thickness: 1,
                          color: Colors.grey[400],
                          indent: 16.0,
                        ),
                      ),
                    ],
                  ),
                  SignInButtonBuilder(
                    image: Container(
                      margin: EdgeInsets.fromLTRB(2.0, 0.0, 55.0, 0.0),
                      child: ClipRRect(
                        child: Image(
                          image: AssetImage('assets/images/google_logo.png'),
                        ),
                      ),
                    ),
                    backgroundColor: kGoogleBlue,
                    onPressed: () => print('Sign in with Google !!!'),
                    text: 'Login with Google',
                    textColor: Colors.white,
                    fontSize: 17.0,
                    width: double.infinity,
                    innerPadding: EdgeInsets.all(0.0),
                    height: 44.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
