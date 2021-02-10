import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:pivotino_flutter_app/screens/activity/activity_screen.dart';
import 'package:pivotino_flutter_app/screens/contact/contact_screen.dart';
import 'package:pivotino_flutter_app/screens/home/components/menu_drawer.dart';
import 'package:pivotino_flutter_app/screens/profile/profile_screen.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/pivotino/home";

  final int navIndex;
  final int tabIndex;

  HomeScreen({this.navIndex = 0, this.tabIndex = 0});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex;

  List<Widget> _bodyItems() => [
        ActivityScreen(),
        ContactScreen(
          initTabIndex: widget.tabIndex,
        ),
        ProfileScreen(),
      ];

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.navIndex;
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> bodyItems = _bodyItems();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: bodyItems[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onNavItemTapped,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              icon: Icon(FeatherIcons.clipboard),
              label: 'Task',
            ),
            BottomNavigationBarItem(
              icon: Icon(FeatherIcons.users),
              label: 'Contacts',
            ),
            BottomNavigationBarItem(
              icon: Icon(FeatherIcons.user),
              label: 'Profile',
            ),
          ],
          selectedItemColor: kFontOrange,
          unselectedItemColor: kFontBlueGrey,
          showUnselectedLabels: false,
        ),
        drawer: MenuDrawer(),
      ),
    );
  }
}
