import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tazks/provider/Tasks.dart';

class SliverBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var tasksList = Provider.of<Tasks>(context).tasks;
    var completed = Provider.of<Tasks>(context).completed;
    
    return SliverAppBar(
      elevation: 6,
      forceElevated: true,
        backgroundColor: Colors.transparent,
        expandedHeight: 200.0,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
              decoration: BoxDecoration(
                
                gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            Colors.lightBlueAccent,
                            Colors.blueAccent
                          ],
                        ),
                // image: DecorationImage(
                //     image: NetworkImage(
                //         'https://images.pexels.com/photos/339144/pexels-photo-339144.jpeg?cs=srgb&dl=abstract-antelope-canyon-art-blur-339144.jpg&fm=jpg'),
                //     fit: BoxFit.cover),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  'Welcome back,',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 30,
                                      color: Colors.white),
                                ),
                                const Text(
                                  'Damian',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 30,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                       
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
                            '${completed.length.toString()}/${tasksList.length.toString()}'
                            ,
                            style: const TextStyle(
                                fontSize: 30, color: Colors.white),
                          ),
                          const Text('Tasks',
                              style: const TextStyle(
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
