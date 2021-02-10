import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pivotino_flutter_app/screens/contact/add_contact_screen.dart';
import 'package:pivotino_flutter_app/screens/contact/components/tabs/company_contact_list.dart';
import 'package:pivotino_flutter_app/screens/contact/components/contact_body.dart';
import 'package:pivotino_flutter_app/screens/contact/components/contact_search.dart';
import 'package:pivotino_flutter_app/screens/contact/components/tabs/personal_contact_list.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class ContactScreen extends StatefulWidget {
  final int initTabIndex;

  ContactScreen({this.initTabIndex = 0});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with SingleTickerProviderStateMixin {
  bool _isCompany = false;
  TabController _tabController;
  int _tabIndex;
  final List<Widget> _tabItems = [
    PersonalContactList(),
    CompanyContactList(),
  ];

  @override
  void initState() {
    super.initState();

    _tabIndex = widget.initTabIndex;

    _tabController = TabController(
      length: _tabItems.length,
      vsync: this,
      initialIndex: _tabIndex,
    );
    _tabController.addListener(() {
      setState(() {
        if (_tabController.index == 1) {
          _isCompany = true;
        } else {
          _isCompany = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ContactBody(_tabController, _tabItems),
    );
  }

  PreferredSize buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(44.0),
      child: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.search,
            color: kFontBlueGrey,
          ),
          onPressed: () {
            print('Searching contact....');
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (BuildContext bc) {
                return ContactSearch(
                  isCompany: _isCompany,
                );
              },
            );
          },
        ),
        elevation: 1.0,
        centerTitle: Platform.isIOS ? true : false,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Text(
          'Contacts',
          style: TextStyle(
            color: kFontDarkBlue,
            fontSize: 17.0,
          ),
        ),
        actions: [
          SizedBox(
            height: Platform.isIOS ? 70.0 : null,
            width: Platform.isIOS ? 70.0 : null,
            child: Platform.isIOS
                ? FlatButton(
                    onPressed: () {
                      print('adding new personal contact...');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddContactScreen(_isCompany),
                        ),
                      );
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(
                        color: kFontOrange,
                        fontWeight: FontWeight.normal,
                        fontSize: 17.0,
                      ),
                    ),
                  )
                : IconButton(
                    icon: Icon(
                      Icons.add,
                      color: kFontOrange,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddContactScreen(_isCompany),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
