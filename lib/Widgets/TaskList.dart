import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tazks/Animations/Waves.dart';
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
  Widget onBottom(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.topCenter,
          child: child,
        ),
      );
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
                    const EdgeInsets.symmetric( vertical: 10),
                child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          // BoxShadow(
                          //     color: Colors.white,
                          //     spreadRadius: 3,
                          //     blurRadius: 4,
                          //     offset: Offset(-4, -4)),
                          BoxShadow(
                              color: Colors.blueGrey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: Offset(0, 0)),
                        ],
                        color: Colors.white,
            
                      ),
                      child: tasksList[index].isCompleted
                          ? Stack(
                              children: <Widget>[
                                Positioned.fill(
                child: AnimatedWave(
                  height: 78,
                  speed: 1,
                  color: Color.fromRGBO(11, 212, 100, 0.55).withAlpha(15),
                ),
                                ),
                                Positioned.fill(
                child: AnimatedWave(
                  height: 60,
                  speed: 1.3,
                  offset: pi,
                  color: Color.fromRGBO(11, 212, 100, 0.3).withAlpha(15),
                ),
                                ),
                                TaskTile(tasksList[index])
                              ],
                            )
                          : Stack(
                              children: <Widget>[
                                Positioned.fill(
                child: AnimatedWave(
                    height: 80,
                    speed: 1,
                    offset: pi,
                    color: Colors.blue.withAlpha(15)),
                                ),
                                Positioned.fill(
                child: AnimatedWave(
                    height: 50,
                    speed: 0.8,
                    offset: pi * 2,
                    color: Colors.lightBlueAccent.withAlpha(15)),
                                ),
                                // Positioned.fill(

                                //   child: AnimatedWave(
                                //     height: 200,
                                //     speed: 1,
                                //     color: Colors.lightBlueAccent,
                                //   ),
                                // ),
                                TaskTile(tasksList[index])
                              ],
                            )),
              )),
        ),
      ),
    );
  }
}
