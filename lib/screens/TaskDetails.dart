import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:tazks/helpers/NotificationHelpers.dart';
import 'package:tazks/provider/Task.dart';
import 'package:tazks/provider/Tasks.dart';
import 'package:intl/intl.dart';
import 'package:tazks/screens/Form.dart';
import '../main.dart';

class TaskDetails extends StatefulWidget {
  static final String routeName = '/task-details';
  PermissionStatus status;
  TaskDetails(this.status);
  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  Task task;
  int _notifyId;
  var _isInit = true;
  var _isLoading = false;
  String _taskId;
  DateTime _remindDate;
  PermissionStatus permission;
  @override
  // void initState() {
    
  //     _isLoading = true;
   

  //   PermissionHandler()
  //       .checkPermissionStatus(PermissionGroup.notification)
  //       .then((res) {
  //     setState(() {
  //       permission = res;
  //       _isLoading = false;
  //     });
  //   });
  //   super.initState();
  // }

  void didChangeDependencies() async {
    if (_isInit) {
      _taskId = ModalRoute.of(context).settings.arguments as String;

      task = Provider.of<Tasks>(context, listen: false).findById(_taskId);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Widget _notifyDateRender(reminderDate) {
    if (reminderDate != null) {
      if (reminderDate.difference(DateTime.now()).inSeconds >= 0) {
        String formattedDate =
            DateFormat('dd/MM/yyy kk:mm').format(reminderDate);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text("Remind me at:"),
            const SizedBox(
              height: 5,
            ),
            Container(
                padding: const EdgeInsets.all(20),
                decoration:
                    BoxDecoration(color: Color.fromRGBO(221, 224, 227, 0.4)),
                child: Text(formattedDate)),
          ],
        );
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }

  Widget _notifications(permission) {
    
    if (permission == PermissionStatus.granted && permission != null) {
      return GestureDetector(
        onTap: () {
          DatePicker.showDateTimePicker(context,
              showTitleActions: true,
              minTime: DateTime(2018),
              maxTime: DateTime(2222),
              onChanged: (date) {}, onConfirm: (date) async {
            _notifyId = Random().nextInt(9999999);
            NotificationHelper.scheduleNotificationReminder(
                flutterLocalNotificationsPlugin, date, _notifyId, task);
            Task _task = Task(
                id: _taskId,
                title: task.title,
                description: task.description,
                isCompleted: task.isCompleted,
                reminderDate: date,
                notifyId: _notifyId);

            Provider.of<Tasks>(context, listen: false)
                .updateTask(_taskId, _task);
            setState(() {
              _remindDate = date;
            });
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
      );
    }
    if (permission == PermissionStatus.denied && permission != null) {
      return Container(
          child: const Icon(
            Icons.alarm_off,
            color: Colors.white,
          ),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  color: Color.fromRGBO(223, 223, 223, 0), width: 0)));
    }
    return Container();
  }

  Widget build(BuildContext context) {
    print(widget.status);
    return
    // return _isLoading
    //     ? Scaffold(
    //         body: Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //       ):
         Scaffold(
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(EditTaskScreen.routeName,
                        arguments: _taskId);
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
                              color: Color.fromRGBO(223, 223, 223, 0),
                              width: 0))),
                ),
                const SizedBox(
                  height: 20,
                ),
               widget.status == PermissionStatus.granted ? GestureDetector(
        onTap: () {
          DatePicker.showDateTimePicker(context,
              showTitleActions: true,
              minTime: DateTime(2018),
              maxTime: DateTime(2222),
              onChanged: (date) {}, onConfirm: (date) async {
            _notifyId = Random().nextInt(9999999);
            NotificationHelper.scheduleNotificationReminder(
                flutterLocalNotificationsPlugin, date, _notifyId, task);
            Task _task = Task(
                id: _taskId,
                title: task.title,
                description: task.description,
                isCompleted: task.isCompleted,
                reminderDate: date,
                notifyId: _notifyId);

            Provider.of<Tasks>(context, listen: false)
                .updateTask(_taskId, _task);
            setState(() {
              _remindDate = date;
            });
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
      ) : Container(
          child: const Icon(
            Icons.alarm_off,
            color: Colors.white,
          ),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  color: Color.fromRGBO(223, 223, 223, 0), width: 0))),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    Provider.of<Tasks>(context, listen: false)
                        .removeTask(_taskId);

                    if (task.notifyId != null) {
                      await NotificationHelper.removeNotification(
                          flutterLocalNotificationsPlugin, task.notifyId);
                    }
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
                              color: Color.fromRGBO(223, 223, 223, 0),
                              width: 0))),
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
                        child: Text(task.title,
                            style: const TextStyle(fontSize: 35))),
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
                    _remindDate != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              const Text("Remind me at:"),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color:
                                          Color.fromRGBO(221, 224, 227, 0.4)),
                                  child: Text(DateFormat('dd/MM/yyy kk:mm')
                                      .format(_remindDate))),
                            ],
                          )
                        : _notifyDateRender(task.reminderDate)
                  ],
                ),
              ),
            ),
          );
  }
}
