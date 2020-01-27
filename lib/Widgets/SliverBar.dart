import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tazks/provider/Tasks.dart';

class SliverBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var tasksList = Provider.of<Tasks>(context).tasks;
    var completed = Provider.of<Tasks>(context).completed;
    
    return SliverAppBar(
     
      elevation: 2,
     
     forceElevated: true,
        backgroundColor: Colors.white,
        expandedHeight: 150.0,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                // gradient: LinearGradient(
                //           begin: Alignment.topLeft,
                //           end: Alignment.bottomRight,
                //           colors: <Color>[
                //             Colors.lightBlueAccent,
                //             Colors.blueAccent
                //           ],
                //         ),
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
                          ),
                       
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    width: 170,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '${completed.length.toString()}/${tasksList.length.toString()}'
                            ,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                                fontSize: 40, color: Colors.black),
                          ),
                          const Text('Tasks',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                  fontSize: 20, color: Colors.black54))
                        ],
                      ),
                    ),
                  ),
                ],
              ),),
        ));
  }
}
