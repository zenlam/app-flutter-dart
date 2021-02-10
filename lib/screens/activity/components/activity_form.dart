import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:pivotino_flutter_app/components/labelled_radio.dart';
import 'package:pivotino_flutter_app/models/mail_activity.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class ActivityForm extends StatefulWidget {
  final MailActivity activity;
  final GlobalKey<FormState> formKey;

  ActivityForm({this.activity, this.formKey});

  @override
  _ActivityFormState createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {
  int _activityTypeRadio = 1;
  DateTime _activityDatetime = DateTime.now();
  DateFormat dateFormatter = DateFormat("dd MMM yyyy 'at' hh:mmaaa");

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Activity Type',
                    style: TextStyle(
                      color: kFontBlueGrey,
                      fontSize: 12.0,
                    ),
                  ),
                  LabelelRadio(
                    label: 'Call',
                    value: 1,
                    groupValue: _activityTypeRadio,
                    onChanged: (int value) {
                      setState(() {
                        _activityTypeRadio = value;
                      });
                    },
                  ),
                  LabelelRadio(
                    label: 'WhatsApp',
                    value: 2,
                    groupValue: _activityTypeRadio,
                    onChanged: (int value) {
                      setState(() {
                        _activityTypeRadio = value;
                      });
                    },
                  ),
                  LabelelRadio(
                    label: 'Email',
                    value: 3,
                    groupValue: _activityTypeRadio,
                    onChanged: (int value) {
                      setState(() {
                        _activityTypeRadio = value;
                      });
                    },
                  ),
                  LabelelRadio(
                    label: 'Meeting',
                    value: 4,
                    groupValue: _activityTypeRadio,
                    onChanged: (int value) {
                      setState(() {
                        _activityTypeRadio = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    validator: (value) {
                      return;
                    },
                    decoration: InputDecoration(
                      hintText: "Title",
                      hintStyle: TextStyle(
                        fontSize: 17.0,
                        color: kFontBlueGrey,
                        fontWeight: FontWeight.normal,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                  Divider(
                    height: 0.0,
                    color: kFontGrey,
                  ),
                  Container(
                    height: 110.0,
                    child: TextFormField(
                      validator: (value) {
                        return;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Note",
                        hintStyle: TextStyle(
                          fontSize: 17.0,
                          color: kFontBlueGrey,
                          fontWeight: FontWeight.normal,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        color: kFontBlue,
                      ),
                      SizedBox(width: 16.0),
                      Icon(
                        Icons.attach_file,
                        color: kFontBlue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Due Date',
                    style: TextStyle(
                      color: kFontBlueGrey,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  InkWell(
                    onTap: () {
                      print('Disable date time picker for now');
                      DatePicker.showDateTimePicker(
                        context,
                        onCancel: () {},
                        currentTime: _activityDatetime,
                      ).then((datetime) {
                        if (datetime != null) {
                          setState(() {
                            _activityDatetime = datetime;
                          });
                        }
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          dateFormatter.format(_activityDatetime),
                          style: TextStyle(
                            color: kFontDarkBlue,
                          ),
                        ),
                        Icon(
                          Icons.calendar_today_rounded,
                          color: kFontBlueGrey,
                          size: 18.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Assigned to',
                    style: TextStyle(
                      color: kFontBlueGrey,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}
