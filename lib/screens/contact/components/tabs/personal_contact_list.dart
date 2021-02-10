import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pivotino_flutter_app/models/res_partner.dart';
import 'package:pivotino_flutter_app/models/filter_item.dart';
import 'package:pivotino_flutter_app/screens/contact/components/contact_tile.dart';
import 'package:pivotino_flutter_app/services/rest_api_service.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class PersonalContactList extends StatefulWidget {
  @override
  _PersonalContactListState createState() => _PersonalContactListState();
}

class _PersonalContactListState extends State<PersonalContactList> {
  ResPartnerList contactList = ResPartnerList(contacts: <ResPartner>[]);
  ResPartnerList fetchedList;
  List<FilterItem> _filterItems = [
    FilterItem(1, "Last Active Date"),
    FilterItem(2, "Name"),
  ];
  FilterItem _selectedFilter;
  ScrollController _scrollController = new ScrollController();
  bool _loadMore = true;
  int _limit = 50;
  int _offset = 0;

  @override
  void initState() {
    super.initState();

    _selectedFilter = _filterItems[0];
    fetchData();
    _scrollController.addListener(() {
      if (_loadMore &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
        _offset += _limit;
        fetchData();
      }
    });
  }

  Future<void> reloadData() async {
    setState(() {
      _offset = 0;
      contactList.contacts.clear();
      fetchData();
    });
  }

  Future fetchData() async {
    final DateTime before = DateTime.now();
    var response = await getData(
      model: ResPartner.modelName,
      fields: ResPartner.fields,
      domain: "[('is_company', '=', False)]",
      limit: _limit,
      offset: _offset,
    );

    if (response.statusCode == 200) {
      fetchedList = ResPartnerList.fromJson(jsonDecode(response.body));

      if (fetchedList.getLength() < _limit) {
        setState(() {
          _loadMore = false;
        });
      }

      contactList.contacts.addAll(fetchedList.contacts);
    } else {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Couldn't Load Contact List"),
            content: Text("Please check your internet"),
          );
        },
      );
    }

    setState(() {});
    final DateTime after = DateTime.now();
    print(after.difference(before));
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
            child: RefreshIndicator(
              onRefresh: () => reloadData(),
              color: kFontOrange,
              child: Container(
                child: ListView.builder(
                  itemCount: contactList.getLength() + 1,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    if (index == contactList.getLength()) {
                      if (_loadMore) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(kFontOrange),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(
                            child: Text(
                              'No more records',
                              style: TextStyle(color: kFontBlueGrey),
                            ),
                          ),
                        );
                      }
                    } else {
                      return ContactTile(
                        contact: contactList.contacts[index],
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
