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
        decoration: BoxDecoration(
            color: task.isCompleted ? Colors.green : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
                color: Color.fromRGBO(223, 223, 223, 1), width: 1.5)),
      ),
    );
  }
}
