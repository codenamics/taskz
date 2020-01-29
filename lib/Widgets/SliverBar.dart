import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tazks/Animations/Waves.dart';
import 'package:tazks/provider/Tasks.dart';
import 'dart:math';

class SliverBar extends StatelessWidget {
  onBottom(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      );

  @override
  Widget build(BuildContext context) {
    var tasksList = Provider.of<Tasks>(context).tasks;
    var completed = Provider.of<Tasks>(context).completed;

    return SliverAppBar(
        elevation: 10,
        forceElevated: true,
        backgroundColor: Color.fromRGBO(233, 240, 245, 1),
        expandedHeight: 175.0,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.white,
                    spreadRadius: 3,
                    blurRadius: 4,
                    offset: Offset(-4, -4)),
                BoxShadow(
                    color: Colors.blueGrey.withOpacity(0.9),
                    spreadRadius: 3,
                    blurRadius: 4,
                    offset: Offset(3, 3)),
              ],
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(36, 125, 229, 1),
                    Color.fromRGBO(10, 67, 191, 1)
                  ]),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        onBottom(AnimatedWave(
                          height: 1000,
                          speed: 1.1,
                          color: Colors.lightBlueAccent.withAlpha(20),
                        )),
                        onBottom(AnimatedWave(
                            height: 1000,
                            speed: 0.85,
                            offset: pi * 6,
                            color: Colors.blue.withAlpha(20))),
                        onBottom(AnimatedWave(
                            height: 1000,
                            speed: 0.9,
                            offset: pi * 8,
                            color: Colors.blueGrey.withAlpha(20))),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text(
                                    'HEY THERE,',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 32,
                                        color: Colors.white),
                                  ),
                                  const Text(
                                    'DAMIAN',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 32,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          '${completed.length.toString()}/${tasksList.length.toString()}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 40,
                                              color: Colors.white),
                                        ),
                                        const Text('Tasks',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                                color: Colors.white))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
