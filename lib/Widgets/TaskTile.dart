import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tazks/Widgets/IsCompleted.dart';
import 'package:tazks/provider/Task.dart';

class TaskTile extends StatelessWidget {
  final dynamic tasksList;
  TaskTile(this.tasksList);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:4),
      child: ListTile(
        title: Text(tasksList.title),
        subtitle: Text(tasksList.description),
        leading: Consumer<Task>(
          builder: (ctx, task, child) => IsCompleted(task)
        ),
      ),
    );
  }
}
