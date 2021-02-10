import 'package:flutter/material.dart';
import 'package:pivotino_flutter_app/models/mail_activity_type.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

import 'components/activity_filter_modal.dart';

class ActivityTab extends StatefulWidget {
  @override
  _ActivityTabState createState() => _ActivityTabState();
}

class _ActivityTabState extends State<ActivityTab> {
  final List<MailActivityType> activityTypes = [
    MailActivityType(false, "Incomplete task"),
    MailActivityType(false, "Complete task"),
    MailActivityType(false, "Call"),
    MailActivityType(false, "WhatsApp"),
    MailActivityType(false, "Email"),
    MailActivityType(false, "Meeting"),
    MailActivityType(false, "With attachment"),
  ];
  int selectedTypeCount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: kChipBorderBlue),
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              child: GestureDetector(
                onTap: () {
                  print('Open activity filter');
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return ActivityFilterModal(
                        activityTypes: activityTypes,
                      );
                    },
                  ).then((value) {
                    setState(() {
                      if (value < 99) {
                        selectedTypeCount = value;
                      }
                    });
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Filter Activity",
                      style: TextStyle(color: kChipTextBlue),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      "(" +
                          selectedTypeCount.toString() +
                          "/" +
                          activityTypes.length.toString() +
                          ")",
                      style: TextStyle(color: kChipTextBlue),
                    ),
                    SizedBox(width: 4.0),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: kChipTextBlue,
                    )
                  ],
                ),
              ),
            ),
          ),
          Divider(
            height: 1.0,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Text(
              'Past Activity',
              style: TextStyle(
                color: kFontBlueGrey,
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.mail_outline,
                      size: 19.0,
                      color: kFontBlueGrey,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Email',
                      style: TextStyle(
                        color: kFontBlueGrey,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '7 Sep 2020 at 10:00AM',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: kFontBlueGrey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                Text(
                  "Follow-up, and sent some feature update. Update them" +
                      " about new feature and products. Request ...",
                  style: TextStyle(
                    color: kFontDarkBlue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
