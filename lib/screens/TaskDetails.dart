import 'dart:convert';
import 'dart:math';

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
  int _notifyId;
  var _isInit = true;
  var _isLoading = false;
  String taskId;
  String notifyDate = '';

  void didChangeDependencies() {
    if (_isInit) {
      var _isLoading = true;
      taskId = ModalRoute.of(context).settings.arguments as String;

      task = Provider.of<Tasks>(context, listen: false).findById(taskId);

      if (task.reminderDate != null) _updateNotifyDateTime(task.reminderDate);
      
    }
    var _isLoading = false;
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateNotifyDateTime(date) {
    String formattedDate = DateFormat('dd/MM/yyy kk:mm').format(date);
    setState(() {
      notifyDate = formattedDate;
    });
  }
  //TO DO
 void removeRemiderDate(task) async {
    var pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();

    if (pendingNotificationRequests.length != 0) {
      pendingNotificationRequests.forEach((f) {
        if (f.id != task.notifyId) {
          print(f.id);
          setState(() {
            notifyDate = '';
          });
        }
      });
    }
  }
 

  Widget build(BuildContext context) {
    print(_isInit);
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
                _notifyId = Random().nextInt(9999999);
                scheduleNotificationReminder(
                    flutterLocalNotificationsPlugin, date, _notifyId, task);
                Task _task = Task(
                    id: taskId,
                    title: task.title,
                    description: task.description,
                    isCompleted: task.isCompleted,
                    reminderDate: date,
                    notifyId: _notifyId);

                Provider.of<Tasks>(context, listen: false)
                    .updateTask(taskId, _task);
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
            onTap: () async {
              if (task.notifyId != null) {
     
                await removeNotification(
                    flutterLocalNotificationsPlugin, task.notifyId);
              } else {
             
                await removeNotification(
                    flutterLocalNotificationsPlugin, _notifyId);
              }
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                  child:
                      Text(task.title, style: const TextStyle(fontSize: 35))),
              const Divider(
                thickness: 3,
                height: 40,
                color: Colors.lightBlueAccent,
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
                thickness: 3,
                height: 40,
                color: Colors.lightBlueAccent,
              ),
              notifyDate == '' || notifyDate == null
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
      ),
    );
  }
}
