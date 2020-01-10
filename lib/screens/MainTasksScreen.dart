import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tazks/Widgets/SliverWidgetBar.dart';
import 'package:tazks/provider/Tasks.dart';
import 'package:tazks/screens/Form.dart';
import 'package:provider/provider.dart';
class MainTasksScreen extends StatefulWidget {
  static const routeName = '/main-tasks-screen';

  @override
  _MainTasksScreenState createState() => _MainTasksScreenState();
}

class _MainTasksScreenState extends State<MainTasksScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var tasksList = Provider.of<Tasks>(context).tasks;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(EditTaskScreen.routeName);
          },
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverWidgetBar(),
            ];
          },
          body: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            itemCount: tasksList.length,
            itemBuilder: (ctx, index) => Dismissible(
              key: Key(index.toString()),
              onDismissed: (direction) {
                Scaffold.of(ctx)
                    .showSnackBar(SnackBar(content: Text(" dismissed")));
              },
              background: Container(color: Colors.red),
              child: ListTile(
                title: Text(tasksList[index].title),
                subtitle: Text(tasksList[index].description),
                leading: Container(

                  child: tasksList[index].isCompleted ? Icon(Icons.done, color: Colors.white,) : null,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: tasksList[index].isCompleted ? Colors.green :  Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          color: Color.fromRGBO(223, 223, 223, 1), width: 1.5)),
                ),
              ),
            ),
          ),
        ));
  }
}
