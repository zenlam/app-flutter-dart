import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pivotino_flutter_app/models/mail_activity.dart';
import 'package:pivotino_flutter_app/screens/activity/components/activity_form.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class AddActivityScreen extends StatefulWidget {
  final int resId;
  final String modelName;

  AddActivityScreen({@required this.resId, @required this.modelName});

  @override
  _AddActivityScreenState createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  MailActivity activity = MailActivity();

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      color: Colors.grey,
      progressIndicator: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(kFontOrange),
      ),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: ActivityForm(
          formKey: _formKey,
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(44.0),
      child: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        leadingWidth: 90.0,
        leading: FlatButton(
          onPressed: () {
            Navigator.maybePop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: kFontBlueGrey,
              fontWeight: FontWeight.normal,
              fontSize: 17.0,
            ),
          ),
        ),
        title: Text(
          'New Task',
          style: TextStyle(
            color: kFontDarkBlue,
            fontSize: 17.0,
          ),
        ),
        centerTitle: true,
        elevation: 1.0,
        actions: [
          SizedBox(
            height: 85.0,
            width: 85.0,
            child: FlatButton(
              onPressed: () async {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Text(
                'Create',
                style: TextStyle(
                  color: kFontOrange,
                  fontSize: 17.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
