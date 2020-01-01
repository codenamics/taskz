import 'package:flutter/material.dart';
import 'package:tazks/screens/AuthScreen.dart';

import 'package:tazks/screens/MainTasksScreen.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthScreen(),
      routes: {
        MainTasksScreen.routeName: (ctx) => MainTasksScreen()
      },
    );
  }
}
