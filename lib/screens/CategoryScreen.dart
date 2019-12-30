import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Welcome back, Damian',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Color.fromRGBO(57, 73, 95, 1)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('You have 5 /14 today',
                        style: TextStyle(
                            fontSize: 24, color: Color.fromRGBO(57, 73, 95, 1))),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              Container(
                height: 300,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(top: 20, left:25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('General', style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(55, 66, 77, 1)),),
                                  Row(
                                    children: <Widget>[Text('12' ), Text('/14')],
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    //                   <--- left side
                                    color: Color.fromRGBO(221, 224, 227, 1),
                                    width: 1.5,
                                  ),
                                  right: BorderSide(
                                    //                    <--- top side
                                    color: Color.fromRGBO(221, 224, 227, 1),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(top: 20, left:25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('Home',style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(55, 66, 77, 1))),
                                  Row(
                                    children: <Widget>[Text('12'), Text('/14')],
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    //                   <--- left side
                                    color: Color.fromRGBO(221, 224, 227, 1),
                                    width: 1.5,
                                  ),
                                  right: BorderSide(
                                    //                    <--- top side
                                    color: Color.fromRGBO(221, 224, 227, 1),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(top: 20, left:25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('Work', style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(55, 66, 77, 1))),
                                  Row(
                                    children: <Widget>[Text('12'), Text('/14')],
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    //                   <--- left side
                                    color: Color.fromRGBO(221, 224, 227, 1),
                                    width: 1.5,
                                  ),
                                  bottom: BorderSide(
                                    //                   <--- left side
                                    color: Color.fromRGBO(221, 224, 227, 1),
                                    width: 1.5,
                                  ),
                                  right: BorderSide(
                                    //                    <--- top side
                                    color: Color.fromRGBO(221, 224, 227, 1),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(top: 20, left:25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('Family', style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(55, 66, 77, 1))),
                                  Row(
                                    children: <Widget>[Text('12'), Text('/14')],
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    //                   <--- left side
                                    color: Color.fromRGBO(221, 224, 227, 1),
                                    width: 1.5,
                                  ),
                                  bottom: BorderSide(
                                    //                   <--- left side
                                    color: Color.fromRGBO(221, 224, 227, 1),
                                    width: 1.5,
                                  ),
                                  right: BorderSide(
                                    //                    <--- top side
                                    color: Color.fromRGBO(221, 224, 227, 1),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
