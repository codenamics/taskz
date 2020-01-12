import 'package:flutter/material.dart';

import 'package:tazks/Widgets/SliverBar.dart';
import 'package:tazks/Widgets/TaskList.dart';

import 'package:tazks/screens/Form.dart';

class MainTasksScreen extends StatefulWidget {
  static const routeName = '/main-tasks-screen';

  @override
  _MainTasksScreenState createState() => _MainTasksScreenState();
}

class _MainTasksScreenState extends State<MainTasksScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(EditTaskScreen.routeName);
          },
        ),
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverBar(),
              ];
            },
            body: TaskList()));
  }
}
