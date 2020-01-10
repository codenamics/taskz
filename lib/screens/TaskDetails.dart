import 'package:flutter/material.dart';

class TaskDetails extends StatefulWidget {
  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
        FloatingActionButton(child: Icon(Icons.edit), onPressed: (){},),
        SizedBox(height: 20,),
        FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(Icons.delete_forever), onPressed: (){},),
      ],),
    
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Task Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 15,
            ),
            Text('Call workers', style: TextStyle(fontSize: 35)),
            Divider(
              height: 40,
              color: Colors.black87,
            ),
            Text('phone 4567898098', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
