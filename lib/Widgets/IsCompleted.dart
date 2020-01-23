import 'package:flutter/material.dart';
import 'package:tazks/provider/Task.dart';

class IsCompleted extends StatelessWidget {
  final Task task;
  IsCompleted(this.task);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        task.toggleStatus();
      },
      child: Container(
          child: task.isCompleted
              ? const Icon(
                  Icons.done,
                  color: Colors.white,
                )
              : null,
          height: 50,
          width: 50,
          decoration: task.isCompleted
              ? BoxDecoration(
                  boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(92, 250, 163, 0.46),
                          spreadRadius: 2.6,
                          blurRadius: 16,
                          offset: Offset(0, 0)),
                    ],
                  color: task.isCompleted
                      ? Color.fromRGBO(11, 212, 100, 0.55)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                      color: Color.fromRGBO(223, 223, 223, 0), width:0))
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                      color: Color.fromRGBO(223, 223, 223, 0.4), width: 1.5),)),
    );
  }
}
