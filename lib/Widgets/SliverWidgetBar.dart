import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tazks/provider/Tasks.dart';

class SliverWidgetBar extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
     var tasksList = Provider.of<Tasks>(context).tasks;
    return SliverAppBar(
        backgroundColor: Colors.transparent,
        expandedHeight: 250.0,
        flexibleSpace: FlexibleSpaceBar(
                  background: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://images.pexels.com/photos/207130/pexels-photo-207130.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
                    fit: BoxFit.cover),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: <Widget>[
                               const Text(
                                  'Welcome back,',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 30,
                                      color: Colors.white),
                                ),
                                Text(
                                  'Damian',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 30,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 5,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                      Colors.lightBlue,
                                      Colors.blueAccent
                                    ])),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.black54,
                    width: 150,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            tasksList.length.toString(),
                            style: TextStyle(
                                fontSize: 30, color: Colors.white),
                          ),
                         const Text('Tasks',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white38))
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }
}