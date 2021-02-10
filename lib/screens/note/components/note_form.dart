import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:pivotino_flutter_app/const/format.dart';
import 'package:pivotino_flutter_app/models/mail_message.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class NoteForm extends StatefulWidget {
  final MailMessage note;
  final GlobalKey<FormState> formKey;

  NoteForm({this.note, this.formKey});

  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  DateTime _activityDatetime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
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
                  'Date and time',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(height: 4.0),
                InkWell(
                  onTap: () {
                    print('Disable date time picker for now');
                    // DatePicker.showDateTimePicker(
                    //   context,
                    //   onCancel: () {},
                    //   currentTime: _activityDatetime,
                    // ).then((datetime) {
                    //   if (datetime != null) {
                    //     setState(() {
                    //       _activityDatetime = datetime;
                    //     });
                    //   }
                    // });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dateFormatter.format(_activityDatetime),
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
          SizedBox(height: 24.0),
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
                  'Note',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                ),
                Container(
                  height: 110.0,
                  child: TextFormField(
                    validator: (value) {
                      widget.note.bodyMessage = value;
                      return;
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Enter notes here",
                      hintStyle: TextStyle(
                        fontSize: 17.0,
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
        ],
      ),
    );
  }
}
