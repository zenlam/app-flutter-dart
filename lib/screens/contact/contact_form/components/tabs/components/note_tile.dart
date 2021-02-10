import 'package:flutter/material.dart';
import 'package:pivotino_flutter_app/const/format.dart';
import 'package:pivotino_flutter_app/models/mail_message.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

import 'note_detail_modal.dart';

class NoteTile extends StatelessWidget {
  final MailMessage note;

  NoteTile({this.note});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return NoteDetailModal(note: note);
          },
        );
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.edit_outlined,
                  size: 19.0,
                  color: kFontBlueGrey,
                ),
                SizedBox(width: 4.0),
                Text(
                  'Note',
                  style: TextStyle(
                    color: kFontBlueGrey,
                  ),
                ),
                SizedBox(width: 8.0),
                note.attachments.length != 0
                    ? Row(
                        children: [
                          Icon(
                            Icons.attach_file,
                            size: 16.0,
                            color: kFontBlue,
                          ),
                          Text(
                            note.attachments.length.toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: kFontBlue,
                            ),
                          )
                        ],
                      )
                    : Container(
                        width: 0.0,
                      ),
                Spacer(),
                Text(
                  dateFormatter.format(note.date),
                  style: TextStyle(
                    fontSize: 12.0,
                    color: kFontBlueGrey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            Text(
              note.bodyMessage,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: kFontDarkBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
