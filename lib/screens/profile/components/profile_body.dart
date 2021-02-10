import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:pivotino_flutter_app/screens/profile/change_password_screen.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 20.0,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22.0,
                    backgroundColor: kFontBlueGrey,
                    child: CircleAvatar(
                      radius: 21.0,
                      child: Icon(
                        FeatherIcons.user,
                        color: kFontBlueGrey,
                      ),
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Text(
                    'Kelvin Wong',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: kFontDarkBlue,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                'Mobile number',
                style: TextStyle(
                  fontSize: 12.0,
                  color: kFontBlueGrey,
                ),
              ),
              subtitle: Text(
                '+60 12-767 9847',
                style: TextStyle(
                  color: kFontDarkBlue,
                  fontSize: 17.0,
                ),
              ),
              tileColor: Colors.white,
              dense: true,
            ),
            _buildDivider(),
            ListTile(
              title: Text(
                'Email address',
                style: TextStyle(
                  fontSize: 12.0,
                  color: kFontBlueGrey,
                ),
              ),
              subtitle: Text(
                'kelvin.wong@gmail.com',
                style: TextStyle(
                  color: kFontDarkBlue,
                  fontSize: 17.0,
                ),
              ),
              tileColor: Colors.white,
              dense: true,
            ),
            SizedBox(height: 32.0),
            Container(
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 0.0, 0.0),
              width: double.infinity,
              color: Colors.white,
              child: Text(
                'Settings',
                style: TextStyle(color: kFontBlueGrey),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ChangePasswordScreen.routeName);
              },
              child: _buildSetting(
                icon: FeatherIcons.lock,
                name: 'Change password',
              ),
            ),
            _buildDivider(),
            _buildSetting(
              icon: Icons.translate,
              name: 'Language',
            ),
            _buildDivider(),
            _buildSetting(
              icon: FeatherIcons.mail,
              name: 'Contact our support',
            ),
            _buildDivider(),
            _buildSetting(
              icon: FeatherIcons.globe,
              name: 'Visit Pivotino Website',
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
              child: Text(
                'Powered by Pivotino. Version 1.0.1',
                style: TextStyle(
                  fontSize: 12.0,
                  color: kFontBlueGrey,
                ),
              ),
            ),
            SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }

  Widget _buildSetting({@required IconData icon, @required String name}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      color: Colors.white,
      child: Row(
        children: [
          Icon(
            icon,
            color: kFontBlueGrey,
            size: 20.0,
          ),
          SizedBox(width: 12.0),
          Text(
            name,
            style: TextStyle(
              fontSize: 16.0,
              color: kFontDarkBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 0.0,
      thickness: 1.0,
      indent: 16.0,
      endIndent: 16.0,
    );
  }
}
