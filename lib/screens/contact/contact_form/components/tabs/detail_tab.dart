import 'package:flutter/material.dart';
import 'package:pivotino_flutter_app/models/res_partner.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class DetailTab extends StatelessWidget {
  final ResPartner contact;

  DetailTab({this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTileTheme(
        tileColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.all(0.0),
          children: [
            buildListTile(
              "Name",
              contact.name,
            ),
            buildDivider(),
            buildListTile(
              "Mobile",
              contact.phone,
            ),
            buildDivider(),
            buildListTile(
              "Email address",
              contact.email,
            ),
            SizedBox(height: 10.0),
            buildListTile(
              "Company name",
              contact.company != null ? contact.company[1] : "",
            ),
            SizedBox(height: 10.0),
            buildListTile(
              "Contact owner",
              contact.contactOwner != null ? contact.contactOwner[1] : "",
            ),
            SizedBox(height: 60.0),
          ],
        ),
      ),
    );
  }

  ListTile buildListTile(String label, var initValue) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontSize: 12.0,
          color: kFontBlueGrey,
        ),
      ),
      subtitle: Text(
        initValue,
        style: TextStyle(
          color: kFontDarkBlue,
          fontSize: 17.0,
        ),
      ),
    );
  }

  Divider buildDivider() {
    return Divider(
      height: 0.0,
      thickness: 1.0,
      indent: 16.0,
      endIndent: 16.0,
    );
  }
}
