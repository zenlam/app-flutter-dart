import 'package:flutter/material.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class ChangePasswordForm extends StatefulWidget {
  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  bool _obsureOldPassword = true;
  bool _obsureNewPassword = true;
  bool _disableButton = true;

  void isEmpty() {
    setState(() {
      if (_oldPasswordController.text.trim() != "" &&
          _newPasswordController.text.trim() != "") {
        _disableButton = false;
      } else {
        _disableButton = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey[100],
      child: Column(
        children: [
          TextField(
            controller: _oldPasswordController,
            onChanged: (value) {
              isEmpty();
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: "Current password",
              labelStyle: TextStyle(
                fontSize: 18.0,
                color: kFontBlueGrey,
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
              suffixIcon: SizedBox(
                child: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye_outlined,
                    size: 24.0,
                    color: _obsureOldPassword ? Colors.grey : Colors.blue,
                  ),
                  onPressed: () {
                    setState(() {
                      _obsureOldPassword = !_obsureOldPassword;
                    });
                  },
                ),
              ),
            ),
            obscureText: _obsureOldPassword,
          ),
          SizedBox(height: 12.0),
          TextField(
            controller: _newPasswordController,
            onChanged: (value) {
              isEmpty();
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: "New password",
              labelStyle: TextStyle(
                fontSize: 18.0,
                color: kFontBlueGrey,
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
              suffixIcon: SizedBox(
                child: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye_outlined,
                    size: 24.0,
                    color: _obsureNewPassword ? Colors.grey : Colors.blue,
                  ),
                  onPressed: () {
                    setState(() {
                      _obsureNewPassword = !_obsureNewPassword;
                    });
                  },
                ),
              ),
            ),
            obscureText: _obsureNewPassword,
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
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              title: Text('Changing password...'),
                              titlePadding: EdgeInsets.all(24.0),
                            );
                          },
                        );
                      }
                    },
                    child: Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    textColor: _disableButton ? Colors.grey[300] : Colors.black,
                    color:
                        _disableButton ? Colors.grey[200] : kPivotinoSecondary,
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
