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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(tasksList.title),
        subtitle: Text(
          tasksList.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
        trailing: tasksList.reminderDate != null
            ? Icon(
                Icons.alarm,
                color: Colors.blueGrey,
                size: 32,
              )
            : Icon(
                Icons.alarm,
                color: Colors.transparent,
              ),
        leading:
            Consumer<Task>(builder: (ctx, task, child) => IsCompleted(task)),
      ),
    );
  }
}
