import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pivotino_flutter_app/models/res_partner.dart';
import 'package:pivotino_flutter_app/models/filter_item.dart';
import 'package:pivotino_flutter_app/screens/contact/components/contact_tile.dart';
import 'package:pivotino_flutter_app/services/rest_api_service.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class CompanyContactList extends StatefulWidget {
  @override
  _CompanyContactListState createState() => _CompanyContactListState();
}

class _CompanyContactListState extends State<CompanyContactList> {
  ResPartnerList contactList = ResPartnerList(contacts: <ResPartner>[]);
  ResPartnerList fetchedList;

  final List<FilterItem> _filterItems = [
    FilterItem(1, "Last Active Date"),
    FilterItem(2, "Last Name"),
    FilterItem(3, "First Name"),
  ];
  FilterItem _selectedFilter;

  @override
  void initState() {
    super.initState();

    _selectedFilter = _filterItems[0];
    getData(
      model: ResPartner.modelName,
      fields: ResPartner.fields,
      domain: "[('is_company', '=', True)]",
      limit: null,
      offset: null,
    ).then((response) {
      if (response.statusCode == 200) {
        fetchedList = ResPartnerList.fromJson(jsonDecode(response.body));
        contactList.contacts.addAll(fetchedList.contacts);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 16.0),
              Text('Count: '),
              Text(
                contactList == null ? '0' : contactList.getLength().toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                'Sort by',
                style: TextStyle(
                  fontSize: 12.0,
                  color: kFontBlueGrey,
                ),
              ),
              SizedBox(width: 8.0),
              DropdownButton<FilterItem>(
                value: _selectedFilter,
                style: TextStyle(
                  color: kFontDarkBlue,
                  fontSize: 15.0,
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: kFontBlueGrey,
                ),
                elevation: 16,
                underline: Container(
                  height: 0,
                ),
                items: _filterItems.map((FilterItem filter) {
                  return DropdownMenuItem(
                    value: filter,
                    child: Text(filter.name),
                  );
                }).toList(),
                onChanged: (FilterItem newFilter) {
                  setState(() {
                    _selectedFilter = newFilter;
                  });
                },
              ),
              SizedBox(width: 16.0),
            ],
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: contactList.getLength() + 1,
                itemBuilder: (context, index) {
                  if (index == contactList.getLength()) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: Text(
                          'No more records',
                          style: TextStyle(color: kFontBlueGrey),
                        ),
                      ),
                    );
                  } else {
                    return ContactTile(
                      contact: contactList.contacts[index],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
