import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tazks/Animations/Waves.dart';
import 'package:tazks/provider/Task.dart';
import 'package:tazks/provider/Tasks.dart';

class IsCompleted extends StatefulWidget {
  final Task task;
  IsCompleted(this.task);

  @override
  _IsCompletedState createState() => _IsCompletedState();
}

class _IsCompletedState extends State<IsCompleted> {
  var ran = Random().nextInt(125) + 85;
  bool _isCompleted;
  var speed = Random().nextInt(1.2.toInt()) + 0.9;
  @override
  void initState() {
    _isCompleted = widget.task.isCompleted;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        setState(() {
          _isCompleted = !_isCompleted;
        });
        Provider.of<Tasks>(context, listen: false).toogleStatus(widget.task.id);
      },
      child: Container(
          child: Stack(children: <Widget>[
            _isCompleted ? Center(child: Icon(Icons.check, color: Colors.white,)) : Container(),
            
// !task._isCompletedpleted ? ClipRRect(
//             borderRadius: BorderRadius.circular(50),
//             child: Container(
              
//               child: Align(
//                 alignment: Alignment.bottomCenter,
//                 child: AnimatedWave(
//                   height: ran.toDouble(),
//                   speed: 1.2,
//                   color: Colors.lightBlueAccent,
//                 ),
//               ),
//             ),
//           ): Container(),
          ],),
          height: 50,
          width: 50,
          decoration: _isCompleted
              ? BoxDecoration(
                  boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(92, 250, 163, 0.46),
                          spreadRadius: 2.6,
                          blurRadius: 16,
                          offset: Offset(0, 0)),
                    ],
                  color: _isCompleted
                      ? Color.fromRGBO(11, 212, 100, 0.55)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                      color: Color.fromRGBO(223, 223, 223, 0), width: 0))
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                      color: Colors.blueGrey.withOpacity(0.2), width: 1.5),
                )),
    );
  }
}
