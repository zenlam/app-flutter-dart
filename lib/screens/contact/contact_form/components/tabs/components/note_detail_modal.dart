import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pivotino_flutter_app/const/format.dart';
import 'package:pivotino_flutter_app/models/mail_message.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class NoteDetailModal extends StatelessWidget {
  final MailMessage note;

  NoteDetailModal({@required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: !Platform.isIOS
            ? BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              )
            : BorderRadius.zero,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                  child: Text(
                    "Close",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16.0,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                Text(
                  "Note",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                    color: kFontDarkBlue,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "Edit",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 0.0,
            thickness: 1.0,
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3.0,
                    horizontal: 8.0,
                  ),
                  child: Text(
                    dateFormatter.format(note.date),
                    style: TextStyle(
                      fontSize: 15.0,
                      color: kFontDarkBlue,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                SizedBox(height: 12.0),
                Container(
                  height: 150.0,
                  child: SingleChildScrollView(
                    child: Text(
                      note.bodyMessage,
                      style: TextStyle(
                        fontSize: 17.0,
                        color: kFontDarkBlue,
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 32.0,
                  thickness: 1.0,
                ),
                Row(
                  children: [
                    Text(
                      "Created by",
                      style: TextStyle(
                        color: kFontBlueGrey,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      note.author[1].toString(),
                      style: TextStyle(
                        color: kFontDarkBlue,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
