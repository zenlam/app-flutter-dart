import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pivotino_flutter_app/models/res_partner.dart';
import 'package:pivotino_flutter_app/screens/contact/components/contact_form.dart';
import 'package:pivotino_flutter_app/screens/contact/contact_form/contact_form_screen.dart';
import 'package:pivotino_flutter_app/services/rest_api_service.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class EditContactScreen extends StatefulWidget {
  static String routeName = "pivotino/contact/edit";
  final bool isCompany;
  final ResPartner contact;

  EditContactScreen(this.isCompany, this.contact);

  @override
  _EditContactScreenState createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future saveContact(BuildContext context) async {
    // set _isLoading to true to trigger the loading overlay
    setState(() {
      _isLoading = true;
    });

    // validate the form to apply all the changes for contact
    _formKey.currentState.validate();

    // call writeData API to write the res.partner record in odoo
    writeData(
      model: "res.partner",
      id: widget.contact.id,
      object: widget.contact,
    ).then((response) {
      setState(() {
        _isLoading = false;
      });
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ContactFormScreen(
              contact: widget.contact,
            ),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Failed to save contact - ${response.statusCode}"),
              content: Text("Content development in progress"),
            );
          },
        );
      }
    });
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
        appBar: buildAppBar(context),
        body: ContactForm(
          isCompany: widget.isCompany,
          contact: widget.contact,
          formKey: _formKey,
        ),
      ),
    );
  }

  PreferredSize buildAppBar(BuildContext context) {
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
          'Edit Contact',
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
                saveContact(context);
              },
              child: Text(
                'Save',
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
