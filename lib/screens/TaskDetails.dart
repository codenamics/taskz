import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:tazks/helpers/NotificationHelpers.dart';
import 'package:tazks/provider/Task.dart';
import 'package:tazks/provider/Tasks.dart';
import 'package:intl/intl.dart';
import 'package:tazks/screens/Form.dart';
import '../main.dart';

class TaskDetails extends StatefulWidget {
  static final String routeName = '/task-details';
  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  Task task;
  var _isInit = true;
  var _isLoading = false;
  String taskId;
  String notifyDate = '';
  void _updateNotifyDateTime(date) {
    String formattedDate = DateFormat('dd/MM/yyy kk:mm').format(date);
    setState(() {
      notifyDate = formattedDate;
    });
  }

  void didChangeDependencies() {
    if (_isInit) {
      var _isLoading = true;
      taskId = ModalRoute.of(context).settings.arguments as String;

      task = Provider.of<Tasks>(context, listen: false).findById(taskId);
    }
    var _isLoading = false;
    _isInit = false;
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
   
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: Key('edit'),
            child: Icon(Icons.edit),
            onPressed: () {
                Navigator.of(context).pushNamed(EditTaskScreen.routeName,
                  arguments: taskId);
            },
          ),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            backgroundColor: Colors.black,
            heroTag: Key('alarm'),
            child: Icon(Icons.alarm),
            onPressed: () {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2018),
                  maxTime: DateTime(2222),
                  onChanged: (date) {}, onConfirm: (date) async {
                setState(() {
                  _updateNotifyDateTime(date);
                });

                scheduleNotificationReminder(
                    flutterLocalNotificationsPlugin, date, int.parse(taskId), task);
              }, currentTime: DateTime.now(), locale: LocaleType.pl);
            },
          ),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            heroTag: Key('delete'),
            backgroundColor: Colors.red,
            child: Icon(Icons.delete_forever),
            onPressed: () {},
          ),
        ],
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Task Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 35,
            ),
            Text("Title"),
            SizedBox(
              height: 5,
            ),
            Container(
                padding: EdgeInsets.all(15),
                color: Color.fromRGBO(221, 224, 227, 0.4),
                child: Text(task.title, style: TextStyle(fontSize: 35))),
            Divider(
              height: 40,
              color: Colors.black87,
            ),
            Text("Description"),
            SizedBox(
              height: 5,
            ),
            Container(
                padding: EdgeInsets.all(15),
                color: Color.fromRGBO(221, 224, 227, 0.4),
                child: Text(task.description, style: TextStyle(fontSize: 18))),
            Divider(
              height: 40,
              color: Colors.black87,
            ),
            notifyDate == ''
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("Remind me at:"),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(221, 224, 227, 0.4)),
                          child: Text(notifyDate)),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
