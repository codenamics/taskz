import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tazks/Widgets/TaskTile.dart';
import 'package:tazks/provider/Task.dart';
import 'package:tazks/provider/Tasks.dart';
import 'package:tazks/screens/TaskDetails.dart';

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
          onDismissed: (direction) {
            Provider.of<Tasks>(context, listen: false)
                .removeTask(tasksList[index].id);
            Scaffold.of(ctx)
                .showSnackBar(SnackBar(content: Text(" dismissed")));
            print(tasksList.length);
          },
          background: Container(color: Colors.red),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(TaskDetails.routeName,
                  arguments: tasksList[index].id);
            },
            child: TaskTile(tasksList[index])
          ),
        ),
      ),
    );
  }
}
