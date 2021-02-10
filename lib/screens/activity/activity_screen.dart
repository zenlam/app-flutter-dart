import 'package:flutter/material.dart';
import 'package:pivotino_flutter_app/screens/activity/components/activity_form.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class ActivityScreen extends StatelessWidget {
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
            'Activity',
            style: TextStyle(
              color: kFontDarkBlue,
              fontSize: 17.0,
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.grey[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Activity Screen',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
