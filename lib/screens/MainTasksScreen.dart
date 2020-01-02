import 'package:flutter/material.dart';
import 'package:tazks/Widgets/SliverWidgetBar.dart';

class MainTasksScreen extends StatefulWidget {
  static const routeName = '/main-tasks-screen';

  @override
  _MainTasksScreenState createState() => _MainTasksScreenState();
}

class _MainTasksScreenState extends State<MainTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverWidgetBar(),
            ];
          },
          body: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: 20,
            itemBuilder: (ctx, index) => Dismissible(
              key: Key(index.toString()),
              onDismissed: (direction) {
                Scaffold.of(ctx)
                    .showSnackBar(SnackBar(content: Text(" dismissed")));
              },
              background: Container(color: Colors.red),
              child: ListTile(
                title: Text('qwer'),
                subtitle: Text('dfdf'),
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
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


