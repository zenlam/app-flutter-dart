import 'package:flutter/material.dart';
import 'package:pivotino_flutter_app/const/url.dart';
import 'package:pivotino_flutter_app/models/res_partner.dart';
import 'package:pivotino_flutter_app/screens/contact/components/contact_action_modal.dart';
import 'package:pivotino_flutter_app/screens/contact/contact_form/contact_form_screen.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class ContactTile extends StatelessWidget {
  final ResPartner contact;

  ContactTile({this.contact});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContactFormScreen(
              contact: contact,
            ),
          ),
        );
      },
      child: Container(
        height: 66.0,
        child: Row(
          children: [
            SizedBox(width: 16.0),
            CircleAvatar(
              backgroundColor: kPivotinoSecondary,
              radius: 24.0,
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 23.0,
                child: CircleAvatar(
                  radius: 22.0,
                  backgroundImage: contact.imageBase64 == ""
                      ? NetworkImage(emptyImageUrl)
                      : MemoryImage(
                          contact.decodeImageBase64(),
                        ),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Container(
              width: 200.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: contact.isCompany
                    ? [
                        Text(
                          contact.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                            color: kFontDarkBlue,
                          ),
                        ),
                      ]
                    : [
                        Text(
                          contact.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                            color: kFontDarkBlue,
                          ),
                        ),
                        Text(
                          contact.company != null ? contact.company[1] : "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: kFontBlueGrey,
                          ),
                        ),
                      ],
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: kFontBlueGrey,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (BuildContext bc) {
                    return ContactActionModal(
                      contact: contact,
                    );
                  },
                );
              },
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[300],
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
