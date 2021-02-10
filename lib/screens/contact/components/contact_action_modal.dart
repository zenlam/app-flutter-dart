import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_brand_icons/flutter_brand_icons.dart';
import 'package:pivotino_flutter_app/models/res_partner.dart';
import 'package:pivotino_flutter_app/screens/contact/contact_form/contact_form_screen.dart';
import 'package:pivotino_flutter_app/screens/home/home_screen.dart';
import 'package:pivotino_flutter_app/services/rest_api_service.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactActionModal extends StatefulWidget {
  final ResPartner contact;

  ContactActionModal({this.contact});

  @override
  _ContactActionModalState createState() => _ContactActionModalState();
}

class _ContactActionModalState extends State<ContactActionModal> {
  Future<void> _launched;

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Center(
        child: Text(
          'Error: ${snapshot.error} !!!',
          style: TextStyle(
            color: kFontRed,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      );
    } else {
      // empty container
      return Container(height: 0.0);
    }
  }

  Future<void> _makeCallSMS(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return _buildActionIOS();
    } else {
      return _buildActionAndroid();
    }
  }

  Container _buildActionAndroid() {
    return Container(
      child: ListTileTheme(
        tileColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ListTile(
              leading: Icon(CupertinoIcons.phone),
              title: Text("Call " + widget.contact.name),
              onTap: () {
                setState(() {
                  _launched = _makeCallSMS('tel:${widget.contact.phone}');
                });
              },
            ),
            ListTile(
              leading: Icon(CupertinoIcons.chat_bubble),
              title: Text("Send a Message"),
              onTap: () {
                setState(() {
                  _launched = _makeCallSMS('sms:${widget.contact.phone}');
                });
              },
            ),
            ListTile(
              leading: Icon(BrandIcons.whatsapp),
              title: Text("Open in WhatsApp"),
            ),
            ListTile(
              leading: Icon(Icons.mail_outline),
              title: Text("Send an Email"),
            ),
            ListTile(
              leading: Icon(CupertinoIcons.list_bullet),
              title: Text("More Details"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactFormScreen(
                      contact: widget.contact,
                    ),
                  ),
                );
              },
            ),
            FutureBuilder<void>(future: _launched, builder: _launchStatus),
          ],
        ),
      ),
    );
  }

  Container _buildActionIOS() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                _buildButton(
                  textValue: "Call " + widget.contact.name,
                  onPressed: () {
                    setState(() {
                      _launched = _makeCallSMS('tel:${widget.contact.phone}');
                    });
                  },
                ),
                _buildDivider(),
                _buildButton(
                  textValue: "Send a Message",
                  onPressed: () {
                    setState(() {
                      _launched = _makeCallSMS('sms:${widget.contact.phone}');
                    });
                  },
                ),
                _buildDivider(),
                _buildButton(
                  textValue: "Open in WhatsApp",
                  onPressed: () {},
                ),
                _buildDivider(),
                _buildButton(
                  textValue: "Send an Email",
                  onPressed: () {},
                ),
                _buildDivider(),
                _buildButton(
                  textValue: "More Details",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactFormScreen(
                          contact: widget.contact,
                        ),
                      ),
                    );
                  },
                ),
                _buildDivider(),
                FlatButton(
                  onPressed: () {
                    unlinkData(
                      model: "res.partner",
                      id: widget.contact.id,
                    ).then((response) {
                      if (response.statusCode == 200) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              navIndex: 1,
                              tabIndex: widget.contact.isCompany ? 1 : 0,
                            ),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                "Failed to delete contact - ${response.statusCode}",
                              ),
                              content: Text("Content development in progress"),
                            );
                          },
                        );
                      }
                    });
                  },
                  child: Text(
                    widget.contact.isCompany
                        ? "Delete Company Contact"
                        : "Delete Contacts",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kFontRed,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 8.0),
          FlatButton(
            minWidth: double.infinity,
            height: 44.0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 16.0,
                color: kDialogTextBlue,
              ),
            ),
          ),
          FutureBuilder<void>(future: _launched, builder: _launchStatus),
        ],
      ),
    );
  }

  FlatButton _buildButton({
    @required String textValue,
    @required Function onPressed,
  }) {
    return FlatButton(
      onPressed: onPressed,
      child: Text(
        textValue,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          color: kDialogTextBlue,
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      height: 1.0,
      color: Colors.grey,
    );
  }
}
