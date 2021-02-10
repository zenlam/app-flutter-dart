import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pivotino_flutter_app/models/mail_message.dart';
import 'package:pivotino_flutter_app/screens/note/components/note_form.dart';
import 'package:pivotino_flutter_app/services/rest_api_service.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class AddNoteScreen extends StatefulWidget {
  final int resId;
  final String modelName;

  AddNoteScreen({@required this.resId, @required this.modelName});

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  MailMessage newNote = MailMessage();

  Future addNote(BuildContext context) async {
    // set _isLoading to true to trigger the loading overlay
    setState(() {
      _isLoading = true;
    });

    // validate the form to apply all the changes for contact
    _formKey.currentState.validate();

    // call postData API to create the new res.partner in odoo
    postData(model: MailMessage.modelName, object: newNote).then((response) {
      setState(() {
        _isLoading = false;
      });
      if (response.statusCode == 200) {
        Navigator.maybePop(context, true);
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Failed to create contact"),
              content: Text("Content development in progress"),
            );
          },
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();

    newNote.model = widget.modelName;
    newNote.resId = widget.resId;
    newNote.messageType = "comment";
  }

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
        body: NoteForm(
          formKey: _formKey,
          note: newNote,
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
            Navigator.maybePop(context, false);
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
          'New Note',
          style: TextStyle(
            color: kFontDarkBlue,
            fontSize: 17.0,
          ),
        ),
        centerTitle: true,
        elevation: 1.0,
        actions: [
          SizedBox(
            height: 75.0,
            width: 75.0,
            child: FlatButton(
              onPressed: () async {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                addNote(context);
              },
              child: Text(
                'Add',
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
