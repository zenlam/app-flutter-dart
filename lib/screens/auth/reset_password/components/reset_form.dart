import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pivotino_flutter_app/components/common_error.dart';
import 'package:pivotino_flutter_app/screens/auth/login/login_screen.dart';
import 'package:pivotino_flutter_app/services/rest_api_service.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class ResetPasswordForm extends StatefulWidget {
  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _emailController = TextEditingController();
  bool _disableButton = true;

  Future sendResetEmail(String email) async {
    // call forgotPassword API and get the response
    var response = await forgotPassword(email: email);

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Email sent"),
            titlePadding: EdgeInsets.all(24.0),
            content: Text("Please check your email inbox"),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                },
                child: Text("Okay"),
              )
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Failed to send email"),
            titlePadding: EdgeInsets.all(24.0),
            content: Text("Reason"),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.maybePop(context);
                },
                child: Text("Try Again"),
              )
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      setState(() {
        if (_emailController.text.trim() != "") {
          _disableButton = false;
        } else {
          _disableButton = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: "Email Address",
            labelStyle: TextStyle(fontSize: 14.0),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFEAEAEA)),
              borderRadius: BorderRadius.zero,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFEAEAEA)),
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  minWidth: double.infinity,
                  height: 44.0,
                  onPressed: () {
                    if (!_disableButton) {
                      if (!EmailValidator.validate(
                          _emailController.text.trim())) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return IncorrectEmailFormat();
                          },
                        );
                      } else {
                        sendResetEmail(_emailController.text.trim());
                      }
                    }
                  },
                  child: Text(
                    'Send email',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  textColor: _disableButton ? Colors.grey[300] : Colors.black,
                  color: _disableButton ? Colors.grey[200] : kPivotinoSecondary,
                ),
                FlatButton(
                  minWidth: double.infinity,
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, LoginScreen.routeName);
                  },
                  child: Text(
                    'Back to Login',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 17.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
