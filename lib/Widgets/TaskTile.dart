import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tazks/Widgets/IsCompleted.dart';
import 'package:tazks/provider/Task.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatelessWidget {
  final Task tasksList;
  TaskTile(this.tasksList);
  @override
  Widget build(BuildContext context) {
   
    Widget _alarm() {
      if (tasksList.reminderDate != null) {
        if (tasksList.reminderDate.difference(DateTime.now()).inSeconds >= 0) {
          
          return Icon(
            Icons.alarm,
            color: Colors.blueGrey,
            size: 34,
          );
        } else {
          Icon(
            Icons.alarm,
            color: Colors.transparent,
          );
        }
      }
      return Icon(
            Icons.alarm,
            color: Colors.transparent,
          );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(
          tasksList.title,
          style: TextStyle(fontSize: 17),
        ),
        subtitle: Text(
          tasksList.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: TextStyle(fontSize: 14),
        ),
        trailing: _alarm(),
        leading:
            Consumer<Task>(builder: (ctx, task, child) => IsCompleted(task)),
      ),
    );
  }
}
