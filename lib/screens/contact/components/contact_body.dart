import 'package:flutter/material.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class ContactBody extends StatefulWidget {
  final TabController tabController;
  final List<Widget> tabItems;

  ContactBody(this.tabController, this.tabItems);

  @override
  _ContactBodyState createState() => _ContactBodyState();
}

class _ContactBodyState extends State<ContactBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0),
        child: Container(
          child: TabBar(
            controller: widget.tabController,
            tabs: [
              Tab(
                text: "Contacts",
              ),
              Tab(
                text: "Companies",
              )
            ],
            indicatorColor: kFontOrange,
            indicatorWeight: 4.0,
            labelColor: kFontOrange,
            unselectedLabelColor: kFontDarkBlue,
            labelStyle: TextStyle(fontSize: 17.0),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: kFontGrey,
                width: 1.0,
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: widget.tabController,
        children: widget.tabItems,
      ),
    );
  }
}
