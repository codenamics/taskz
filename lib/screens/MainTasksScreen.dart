import 'package:flutter/material.dart';

class MainTasksScreen extends StatefulWidget {
  static const routeName = '/main-tasks-screen';

  @override
  _MainTasksScreenState createState() => _MainTasksScreenState();
}

class _MainTasksScreenState extends State<MainTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10.0,
          child: Container(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.home,
                      size: 25,
                      color: Colors.black54,
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5),
                  child: IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      size: 25,
                      color: Colors.black54,
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: IconButton(
                    icon: Icon(
                      Icons.phone,
                      size: 25,
                      color: Colors.black54,
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.account_circle,
                      size: 25,
                      color: Colors.black54,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          color: Colors.white,
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                  backgroundColor: Colors.transparent,
                  expandedHeight: 250.0,
                  flexibleSpace: Container(
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
                                        Text(
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
                                    '24',
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.white),
                                  ),
                                  Text('Tasks',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white38))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ))),
            ];
          },
          body: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            
            itemCount: 20,
            itemBuilder: (ctx, index) => Dismissible(
              key: Key(index.toString()),
              onDismissed: (direction) {
                // Remove the item from the data source.
              

                // Then show a snackbar.
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
