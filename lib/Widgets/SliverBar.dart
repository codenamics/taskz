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
        backgroundColor: Color.fromRGBO(233, 240, 245, 1),
        expandedHeight: 175.0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.white,
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 0)),
            ],
          ),
          child: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(233, 240, 245, 1)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          onBottom(AnimatedWave(
                            height: 110,
                            speed: 1.1,
                            color: Colors.lightBlueAccent,
                          )),
                          onBottom(AnimatedWave(
                              height: 150,
                              speed: 0.85,
                              offset: pi,
                              color: Colors.blue)),
                          onBottom(AnimatedWave(
                              height: 50,
                              speed: 0.9,
                              offset: pi * 2,
                              color: Colors.blueGrey)),
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
                                          color: Colors.black),
                                    ),
                                    const Text(
                                      'DAMIAN',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 32,
                                          color: Colors.black54),
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
                                                color: Colors.black),
                                          ),
                                          const Text('Tasks',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20,
                                                  color: Colors.black54))
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
          ),
        ));
  }
}
