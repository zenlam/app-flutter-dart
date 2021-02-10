import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pivotino_flutter_app/models/res_country.dart';
import 'package:pivotino_flutter_app/models/res_country_state.dart';
import 'package:pivotino_flutter_app/models/res_partner.dart';
import 'package:pivotino_flutter_app/models/res_users.dart';
import 'package:pivotino_flutter_app/services/rest_api_service.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class M2oFieldModal extends StatefulWidget {
  final String title;
  final String modelName;
  final List<String> modelFields;
  final String domain;

  M2oFieldModal({
    @required this.title,
    @required this.modelName,
    @required this.modelFields,
    this.domain,
  });

  @override
  _M2oFieldModalState createState() => _M2oFieldModalState();
}

class _M2oFieldModalState extends State<M2oFieldModal> {
  List dataList = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    var response = await getData(
      model: widget.modelName,
      fields: widget.modelFields,
      order: "id ASC",
      domain: widget.domain == null ? "" : widget.domain,
    );

    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);
      if (widget.modelName == "res.users") {
        dataList.addAll(ResUsersList.fromJson(decodedJson).users);
      } else if (widget.modelName == "res.partner") {
        dataList.addAll(ResPartnerList.fromJson(decodedJson).contacts);
      } else if (widget.modelName == "res.country") {
        dataList.addAll(ResCountryList.fromJson(decodedJson).countries);
      } else if (widget.modelName == "res.country.state") {
        dataList.addAll(ResCountryStateList.fromJson(decodedJson).states);
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: !Platform.isIOS ? 40.0 : 24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: !Platform.isIOS
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: kFontDarkBlue,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                    color: kFontDarkBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    "Create",
                    style: TextStyle(
                      color: kFontOrange,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 0.0,
            color: kFontBlueGrey,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 8.0,
            ),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              height: 36.0,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20.0,
                    color: kFontBlueGreyLight,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: "Search",
                  labelStyle: TextStyle(color: kFontBlueGreyLight),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: dataList.length == 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(kFontOrange),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pop(context, [
                              dataList[index].id,
                              dataList[index].name,
                            ]);
                          },
                          child: Container(
                            child: ListTile(
                              title: Text(dataList[index].name),
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
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
