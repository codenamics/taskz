import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tazks/Widgets/TaskTile.dart';
import 'package:tazks/helpers/NotificationHelpers.dart';
import 'package:tazks/provider/Tasks.dart';
import 'package:tazks/screens/TaskDetails.dart';
import '../main.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final tasksList = Provider.of<Tasks>(context).tasks;
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      itemCount: tasksList.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: tasksList[index],
        child: Dismissible(
          key: ValueKey(tasksList[index].id),
          onDismissed: (direction) async {
            Provider.of<Tasks>(context, listen: false)
                .removeTask(tasksList[index].id);
            if (tasksList[index].notifyId != null) {
              await NotificationHelper.removeNotification(
                  flutterLocalNotificationsPlugin, tasksList[index].notifyId);
            }

            Scaffold.of(ctx)
                .showSnackBar(SnackBar(content: Text(" dismissed")));
          },
          background: Container(color: Colors.red),
          child: GestureDetector(
              onTap: () async {
                Navigator.of(context).pushNamed(TaskDetails.routeName,
                    arguments: tasksList[index].id);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TaskTile(tasksList[index])),
              )),
        ),
      ),
    );
  }
}
