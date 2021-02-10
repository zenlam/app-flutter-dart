import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Drawer(
        child: ListView(
          children: [
            buildAppMenu(
              menuName: "Activity",
              iconAsset: "activity_menu",
            ),
            buildAppMenu(
              menuName: "Calendar",
              iconAsset: "calendar_menu",
            ),
            buildAppMenu(
              menuName: "Contact",
              iconAsset: "contact_menu",
            ),
            buildAppMenu(
              menuName: "CRM",
              iconAsset: "crm_menu",
            ),
            buildAppMenu(
              menuName: "Dashboard",
              iconAsset: "dashboard_menu",
            ),
            buildAppMenu(
              menuName: "Sale",
              iconAsset: "sale_menu",
            ),
          ],
        ),
      ),
    );
  }

  Stack buildAppMenu({String menuName, String iconAsset}) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Image.asset("assets/images/" + iconAsset + ".png"),
        Positioned(
          left: 16.0,
          child: Text(
            menuName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
            ),
          ),
        )
      ],
    );
  }
}
