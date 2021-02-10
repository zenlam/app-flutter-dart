import 'package:flutter/material.dart';
import 'package:pivotino_flutter_app/models/mail_message.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

import 'components/note_tile.dart';

class NoteTab extends StatefulWidget {
  final MailMessageList noteList;

  NoteTab({this.noteList});

  @override
  _NoteTabState createState() => _NoteTabState();
}

class _NoteTabState extends State<NoteTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: widget.noteList == null
                ? Center(
                    child: Text(
                      'No note available',
                      style: TextStyle(color: kFontBlueGrey),
                    ),
                  )
                : ListView.builder(
                    itemCount: widget.noteList.getLength() + 1,
                    itemBuilder: (context, index) {
                      if (index == widget.noteList.getLength()) {
                        return SizedBox(height: 40.0);
                      } else {
                        return Column(
                          children: [
                            SizedBox(height: 12.0),
                            NoteTile(
                              note: widget.noteList.notes[index],
                            ),
                          ],
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
