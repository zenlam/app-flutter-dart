import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pivotino_flutter_app/const/url.dart';
import 'package:pivotino_flutter_app/models/mail_message.dart';
import 'package:pivotino_flutter_app/models/res_partner.dart';
import 'package:pivotino_flutter_app/screens/activity/add_activity_screen.dart';
import 'package:pivotino_flutter_app/screens/contact/contact_form/components/contact_action_button.dart';
import 'package:pivotino_flutter_app/screens/contact/contact_form/components/tabs/activity_tab.dart';
import 'package:pivotino_flutter_app/screens/contact/contact_form/components/tabs/detail_tab.dart';
import 'package:pivotino_flutter_app/screens/contact/contact_form/components/tabs/note_tab.dart';
import 'package:pivotino_flutter_app/screens/note/add_note_screen.dart';
import 'package:pivotino_flutter_app/services/rest_api_service.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class ContactFormBody extends StatefulWidget {
  final ResPartner contact;

  ContactFormBody({this.contact});

  @override
  _ContactFormBodyState createState() => _ContactFormBodyState();
}

class _ContactFormBodyState extends State<ContactFormBody>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Color _dialBackground, _dialForeground;
  bool _dialVisible = true;
  MailMessageList noteList;

  Future fetchNote() async {
    var noteDomain = [
      "('message_type', '=', 'comment')",
      "('model', '=', '${ResPartner.modelName}')",
      "('res_id', '=', ${widget.contact.id})",
    ];
    var response = await getData(
      model: MailMessage.modelName,
      fields: MailMessage.fields,
      domain: noteDomain.toString(),
    );

    if (response.statusCode == 200) {
      noteList = MailMessageList.fromJson(jsonDecode(response.body));
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    fetchNote();
    _tabController.addListener(() {
      setState(() {
        if (_tabController.index != 2) {
          _dialVisible = true;
        } else {
          _dialVisible = false;
        }
      });
    });

    _dialBackground = kFontOrange;
    _dialForeground = Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            SizedBox(height: 16.0),
            Center(
              child: CircleAvatar(
                maxRadius: 44.0,
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                backgroundImage: widget.contact.imageBase64 == ""
                    ? NetworkImage(emptyImageUrl)
                    : MemoryImage(
                        widget.contact.decodeImageBase64(),
                      ),
              ),
            ),
            SizedBox(height: 16.0),
            ContactActionButton(
              contact: widget.contact,
            ),
            SizedBox(height: 16.0),
            Container(
              height: 40.0,
              child: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    text: "Activity",
                  ),
                  Tab(
                    text: "Note",
                  ),
                  Tab(
                    text: "Details",
                  ),
                ],
                indicatorColor: kFontOrange,
                indicatorWeight: 3.0,
                labelColor: kFontOrange,
                unselectedLabelColor: kFontDarkBlue,
                labelStyle: TextStyle(fontSize: 16.0),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: kFontGrey,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ActivityTab(),
                    NoteTab(
                      noteList: noteList,
                    ),
                    DetailTab(
                      contact: widget.contact,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: buildSpeedDial(context),
    );
  }

  SpeedDial buildSpeedDial(BuildContext context) {
    return SpeedDial(
      backgroundColor: _dialBackground,
      foregroundColor: _dialForeground,
      visible: _dialVisible,
      animatedIcon: AnimatedIcons.add_event,
      overlayOpacity: 0.9,
      onClose: () {
        setState(() {
          _dialBackground = kFontOrange;
          _dialForeground = Colors.white;
        });
      },
      onOpen: () {
        setState(() {
          _dialBackground = Colors.white;
          _dialForeground = kFontOrange;
        });
      },
      children: [
        SpeedDialChild(
          labelWidget: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Text(
              'Add Note',
              style: TextStyle(fontSize: 17.0),
            ),
          ),
          child: Icon(FeatherIcons.edit),
          backgroundColor: kFontOrange,
          labelStyle: TextStyle(fontSize: 17.0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNoteScreen(
                  resId: widget.contact.id,
                  modelName: ResPartner.modelName,
                ),
              ),
            ).then((value) {
              print(value);
              if (value == true) {
                if (noteList != null) {
                  noteList.notes.clear();
                }
                fetchNote();
              }
            });
          },
        ),
        SpeedDialChild(
          labelWidget: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Text(
              'Create Task',
              style: TextStyle(fontSize: 17.0),
            ),
          ),
          child: Icon(FeatherIcons.calendar),
          backgroundColor: kFontOrange,
          labelStyle: TextStyle(fontSize: 17.0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddActivityScreen(
                  resId: widget.contact.id,
                  modelName: ResPartner.modelName,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
