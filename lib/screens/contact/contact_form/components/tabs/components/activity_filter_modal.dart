import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pivotino_flutter_app/models/mail_activity_type.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class ActivityFilterModal extends StatefulWidget {
  final List<MailActivityType> activityTypes;

  ActivityFilterModal({this.activityTypes});

  @override
  _ActivityFilterModalState createState() => _ActivityFilterModalState();
}

class _ActivityFilterModalState extends State<ActivityFilterModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: Platform.isIOS
            ? BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              )
            : BorderRadius.zero,
      ),
      // TODO: FIXME: need to make the height dynamic
      height: Platform.isIOS
          ? MediaQuery.of(context).size.height - 50
          : MediaQuery.of(context).size.height - 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onPressed: () {
                  print('Cancel Activity Filter');
                  Navigator.pop(context, 99);
                },
              ),
              Text(
                'Filter Activity',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FlatButton(
                onPressed: () {
                  print('Applying activity filter...');
                  var selectedType = widget.activityTypes
                      .where((type) => type.selected == true);
                  Navigator.pop(context, selectedType.length);
                },
                child: Text(
                  'Apply',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: kFontOrange,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: widget.activityTypes
                    .map(
                      (type) => Container(
                        child: Row(
                          children: [
                            Checkbox(
                              value: type.selected,
                              onChanged: (value) {
                                setState(() {
                                  type.selected = value;
                                });
                              },
                            ),
                            Text(type.activityName),
                          ],
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[300],
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
