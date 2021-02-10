import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class ContactSearch extends StatelessWidget {
  final bool isCompany;

  ContactSearch({this.isCompany});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Platform.isIOS ? 40.0 : 24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: Platform.isIOS
            ? BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              )
            : BorderRadius.zero,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60.0,
            padding: Platform.isIOS
                ? const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 8.0,
                  )
                : null,
            child: Platform.isIOS
                ? _buildSearchBarIOS(context)
                : _buildSearchBarAndroid(context),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 6.0,
            ),
            color: Colors.grey[200],
            child: Text(
              "Recently searched",
              style: TextStyle(
                fontSize: 12.0,
                color: kFontBlueGrey,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: Text(
                    "Person " + index.toString(),
                    style: TextStyle(
                      fontSize: 17.0,
                      color: kFontDarkBlue,
                    ),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBarAndroid(context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kFontBlueGreyLight,
            size: 24.0,
          ),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
        Flexible(
          child: TextField(
            decoration: InputDecoration(
              hintText: isCompany ? "Search Company" : "Search Contact",
              hintStyle: TextStyle(
                color: kFontBlueGreyLight,
                fontSize: 20.0,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBarIOS(context) {
    return Row(
      children: [
        Flexible(
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: Icon(
                Icons.search,
                color: kFontBlueGreyLight,
              ),
              hintText: isCompany ? "Search Company" : "Search Contact",
              hintStyle: TextStyle(
                color: kFontBlueGreyLight,
              ),
              contentPadding: EdgeInsets.all(8.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style: TextStyle(
              fontSize: 17.0,
              color: kFontBlueGrey,
              fontWeight: FontWeight.normal,
            ),
          ),
        )
      ],
    );
  }
}
