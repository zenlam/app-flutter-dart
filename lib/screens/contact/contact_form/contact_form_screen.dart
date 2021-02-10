import 'package:flutter/material.dart';
import 'package:pivotino_flutter_app/models/res_partner.dart';
import 'package:pivotino_flutter_app/screens/contact/contact_form/components/contact_form_body.dart';
import 'package:pivotino_flutter_app/screens/contact/edit_contact_screen.dart';
import 'package:pivotino_flutter_app/screens/home/home_screen.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class ContactFormScreen extends StatefulWidget {
  final ResPartner contact;

  ContactFormScreen({this.contact});

  @override
  _ContactFormScreenState createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ContactFormBody(
        contact: widget.contact,
      ),
    );
  }

  PreferredSize buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(44.0),
      child: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  navIndex: 1,
                  tabIndex: widget.contact.isCompany ? 1 : 0,
                ),
              ),
            );
          },
        ),
        elevation: 1.0,
        title: Text(
          widget.contact.name,
          style: TextStyle(
            color: kFontDarkBlue,
            fontSize: 17.0,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: kFontBlueGrey,
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        actions: [
          SizedBox(
            height: 70.0,
            width: 70.0,
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditContactScreen(
                      widget.contact.isCompany,
                      widget.contact,
                    ),
                  ),
                );
              },
              child: Text(
                'Edit',
                style: TextStyle(
                  color: kFontOrange,
                  fontWeight: FontWeight.normal,
                  fontSize: 17.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
