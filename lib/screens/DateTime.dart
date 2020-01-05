import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tazks/helpers/NotificationHelpers.dart';

import '../main.dart';

class DateTimeForm extends StatefulWidget {
  @override
  _DateTimeFormState createState() => _DateTimeFormState();
}

class _DateTimeFormState extends State<DateTimeForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FlatButton(
            onPressed: () {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2018),
                  maxTime: DateTime(2222), onChanged: (date) {
                print('change $date');
              }, onConfirm: (date) async {
              

               scheduleNotificationReminder(flutterLocalNotificationsPlugin,date);
              }, currentTime: DateTime.now(), locale: LocaleType.pl);
            },
            child: Text(
              'show date time picker ',
              style: TextStyle(color: Colors.blue),
            )),
      ),
    );
  }
}
