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
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(EditTaskScreen.routeName);
          },
          child: Container(
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(182, 226, 246, 1),
                        spreadRadius: 3,
                        blurRadius: 15,
                        offset: Offset(0, 0)),
                  ],
                  color: Colors.lightBlueAccent.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                      color: Color.fromRGBO(223, 223, 223, 0), width: 0))),
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
