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
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(EditTaskScreen.routeName, arguments: taskId);
            },
            child: Container(
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(182, 226, 246, 1),
                          spreadRadius: 2,
                          blurRadius: 15,
                          offset: Offset(0, 0)),
                    ],
                    color: Colors.lightBlueAccent.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                        color: Color.fromRGBO(223, 223, 223, 0), width: 0))),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2018),
                  maxTime: DateTime(2222),
                  onChanged: (date) {}, onConfirm: (date) async {
                setState(() {
                  _updateNotifyDateTime(date);
                });

                scheduleNotificationReminder(flutterLocalNotificationsPlugin,
                    date, int.parse(taskId), task);
              }, currentTime: DateTime.now(), locale: LocaleType.pl);
            },
            child: Container(
                child: const Icon(
                  Icons.alarm,
                  color: Colors.white,
                ),
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 15,
                          offset: Offset(0, 0)),
                    ],
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                        color: Color.fromRGBO(223, 223, 223, 0), width: 0))),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Provider.of<Tasks>(context, listen: false).removeTask(taskId);
              Navigator.of(context).pop();
            },
            child: Container(
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.redAccent.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 15,
                          offset: Offset(0, 0)),
                    ],
                    color: Colors.redAccent.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                        color: Color.fromRGBO(223, 223, 223, 0), width: 0))),
          ),
        ],
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Task Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 35,
            ),
            const Text("Title"),
            const SizedBox(
              height: 5,
            ),
            Container(
                padding: const EdgeInsets.all(15),
                color: Color.fromRGBO(221, 224, 227, 0.4),
                child: Text(task.title, style: const TextStyle(fontSize: 35))),
            const Divider(
              height: 40,
              color: Colors.black87,
            ),
            const Text("Description"),
            const SizedBox(
              height: 5,
            ),
            Container(
                padding: const EdgeInsets.all(15),
                color: Color.fromRGBO(221, 224, 227, 0.4),
                child: Text(task.description,
                    style: const TextStyle(fontSize: 18))),
            const Divider(
              height: 40,
              color: Colors.black87,
            ),
            notifyDate == ''
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Text("Remind me at:"),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                          padding: const EdgeInsets.all(20),
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
