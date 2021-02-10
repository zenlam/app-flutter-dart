import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_brand_icons/flutter_brand_icons.dart';
import 'package:pivotino_flutter_app/models/res_partner.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactActionButton extends StatefulWidget {
  final ResPartner contact;

  ContactActionButton({this.contact});

  @override
  _ContactActionButtonState createState() => _ContactActionButtonState();
}

class _ContactActionButtonState extends State<ContactActionButton> {
  Future<void> _launched;

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
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
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              RawMaterialButton(
                fillColor: Colors.white,
                child: Icon(
                  CupertinoIcons.phone,
                  color: kFontBlueGrey,
                ),
                padding: EdgeInsets.all(8.0),
                shape: CircleBorder(),
                constraints: BoxConstraints(minWidth: 72.0),
                elevation: 0.0,
                onPressed: () {
                  setState(() {
                    _launched = _makeCallSMS('tel:${widget.contact.phone}');
                  });
                },
              ),
              SizedBox(height: 4.0),
              Text(
                'Call',
                style: TextStyle(
                  color: kFontBlueGrey,
                ),
              ),
            ],
          ),
          widget.contact.isCompany
              ? Container(width: 0.0)
              : Column(
                  children: [
                    RawMaterialButton(
                      fillColor: kWhatsAppGreen,
                      child: Icon(
                        BrandIcons.whatsapp,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(8.0),
                      shape: CircleBorder(),
                      constraints: BoxConstraints(minWidth: 72.0),
                      elevation: 0.0,
                      onPressed: () => print('redirect to WhatsApp'),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'WhatsApp',
                      style: TextStyle(
                        color: kFontBlueGrey,
                      ),
                    ),
                  ],
                ),
          Column(
            children: [
              RawMaterialButton(
                fillColor: Colors.white,
                child: Icon(
                  Icons.mail_outline,
                  color: kFontBlueGrey,
                ),
                padding: EdgeInsets.all(8.0),
                shape: CircleBorder(),
                constraints: BoxConstraints(minWidth: 72.0),
                elevation: 0.0,
                onPressed: () => print('redirect to Email'),
              ),
              SizedBox(height: 4.0),
              Text(
                'Email',
                style: TextStyle(
                  color: kFontBlueGrey,
                ),
              ),
            ],
          ),
          widget.contact.isCompany
              ? Container(width: 0.0)
              : Column(
                  children: [
                    RawMaterialButton(
                      fillColor: Colors.white,
                      child: Icon(
                        CupertinoIcons.chat_bubble,
                        color: kFontBlueGrey,
                      ),
                      padding: EdgeInsets.all(8.0),
                      shape: CircleBorder(),
                      constraints: BoxConstraints(minWidth: 72.0),
                      elevation: 0.0,
                      onPressed: () {
                        setState(() {
                          _launched =
                              _makeCallSMS('sms:${widget.contact.phone}');
                        });
                      },
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Message',
                      style: TextStyle(
                        color: kFontBlueGrey,
                      ),
                    ),
                  ],
                ),
          FutureBuilder<void>(future: _launched, builder: _launchStatus),
        ],
      ),
    );
  }
}
