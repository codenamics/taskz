import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:tazks/helpers/NotificationHelpers.dart';
import 'package:tazks/main.dart';
import 'package:tazks/provider/Task.dart';
import 'package:tazks/provider/Tasks.dart';
import 'package:tazks/screens/DateTime.dart';
import 'package:intl/intl.dart';

class EditTaskScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _dateTimeController = TextEditingController();
  final _form = GlobalKey<FormState>();

  DateTime dateTime;
  var _editedTask = Task(id: Random().nextInt(30).toString(), title: '', description: '');
  var _initValues = {'title': '', 'description': ''};
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // if (_isInit) {
    //   final productId = ModalRoute.of(context).settings.arguments as String;
    //   if (productId != null) {
    //     _editedProduct =
    //         Provider.of<Products>(context, listen: false).findById(productId);
    //     _initValues = {
    //       'title': _editedProduct.title,
    //       'description': _editedProduct.description,
    //       'price': _editedProduct.price.toString(),
    //       // 'imageUrl': _editedProduct.imageUrl,
    //       'imageUrl': '',
    //     };
    //     _imageUrlController.text = _editedProduct.imageUrl;
    //   }
    // }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _dateTimeController.dispose();

    super.dispose();
  }

  void _updateNotifyDateTime(date) {
    String formattedDate = DateFormat('dd/MM/yyy kk:mm').format(date);
    setState(() {
      _dateTimeController.text = formattedDate;
    });
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
  Provider.of<Tasks>(context, listen: false).addTask(_editedTask);
  Navigator.of(context).pop();
    // if (_editedProduct.id != null) {
    //  await Provider.of<Products>(context, listen: false)
    //       .updateProduct(_editedProduct.id, _editedProduct);

    // } else {
    //   try {
    //     await Provider.of<Products>(context, listen: false)
    //         .addProduct(_editedProduct);
    //   } catch (e) {
    //    await showDialog(
    //       context: context,
    //       builder: (ctx) => AlertDialog(
    //         title: Text('An error occurred!'),
    //         content: Text('Something went wrong.'),
    //         actions: <Widget>[
    //           FlatButton(
    //             child: Text('Okay'),
    //             onPressed: () {
    //               setState(() {
    //                 _isLoading = false;
    //               });
    //               Navigator.of(ctx).pushNamed(UserProductsScreen.routeName);
    //             },
    //           )
    //         ],
    //       ),
    //     );
    //   }
    // }
    //   setState(() {
    //     _isLoading = false;
    //   });
    //   Navigator.of(context).pop();
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    print(_initValues['dateTime']);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[400], width: 1.0),
                          ),
                          fillColor: Color.fromRGBO(221, 224, 227, 0.4),
                          labelText: 'Title'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        print(value);
                    _editedTask = Task(id: _editedTask.id, title: value, description: _editedTask.description);
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[400], width: 1.0),
                          ),
                          fillColor: Color.fromRGBO(221, 224, 227, 0.4),
                          labelText: 'Description'),
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a description.';
                        }
                        if (value.length < 10) {
                          return 'Should be at least 10 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        print(value);
                     _editedTask = Task(id: _editedTask.id, title: _editedTask.title, description: value);
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    RaisedButton(
                      color: Colors.blueAccent,
                      onPressed: _saveForm,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Add Task',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    // TextFormField(
                    //   controller: _dateTimeController,
                    //   decoration: InputDecoration(
                    //       filled: true,
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide:
                    //             BorderSide(color: Colors.grey[400], width: 1.0),
                    //       ),
                    //       fillColor: Color.fromRGBO(221, 224, 227, 0.4),
                    //       labelText: 'Remind'),
                    //   keyboardType: TextInputType.datetime,
                    //   onSaved: (value) {
                    //     print(value);
                    //     // _editedProduct = Product(
                    //     //   title: _editedProduct.title,
                    //     //   price: _editedProduct.price,
                    //     //   description: value,
                    //     //   imageUrl: _editedProduct.imageUrl,
                    //     //   id: _editedProduct.id,
                    //     //   isFavorite: _editedProduct.isFavorite,
                    //     // );
                    //   },
                    // ),
                    // Center(
                    //   child: RaisedButton(
                    //       onPressed: () {
                    //         DatePicker.showDateTimePicker(context,
                    //             showTitleActions: true,
                    //             minTime: DateTime(2018),
                    //             maxTime: DateTime(2222),
                    //             onChanged: (date) {}, onConfirm: (date) async {
                    //           setState(() {
                    //             _updateNotifyDateTime(date);
                    //           });

                    //           scheduleNotificationReminder(
                    //               flutterLocalNotificationsPlugin, date);
                    //         },
                    //             currentTime: DateTime.now(),
                    //             locale: LocaleType.pl);
                    //       },
                    //       child: Text(
                    //         'Pick date',
                    //         style: TextStyle(color: Colors.blue),
                    //       )),
                    // ),
                  ],
                ),
              ),
            ),
    );
  }
}
