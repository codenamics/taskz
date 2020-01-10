import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:tazks/screens/DateTime.dart';
import 'package:intl/intl.dart';

class EditTaskScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _dateTimeController = TextEditingController();
  final _form = GlobalKey<FormState>();

  DateTime dateTime;
  var _initValues = {'title': 'lll', 'description': 'lll'};
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
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
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
    // _form.currentState.save();
    // setState(() {
    //   _isLoading = true;
    // });
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
                      readOnly: true,
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[400], width: 1.0),
                          ),
                          fillColor: Color.fromRGBO(221, 224, 227, 0.4),
                          labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        print(value);
                        // _editedProduct = Product(
                        //     title: value,
                        //     price: _editedProduct.price,
                        //     description: _editedProduct.description,
                        //     imageUrl: _editedProduct.imageUrl,
                        //     id: _editedProduct.id,
                        //     isFavorite: _editedProduct.isFavorite);
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
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
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
                        // _editedProduct = Product(
                        //   title: _editedProduct.title,
                        //   price: _editedProduct.price,
                        //   description: value,
                        //   imageUrl: _editedProduct.imageUrl,
                        //   id: _editedProduct.id,
                        //   isFavorite: _editedProduct.isFavorite,
                        // );
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _dateTimeController,
                      decoration: InputDecoration(
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[400], width: 1.0),
                          ),
                          fillColor: Color.fromRGBO(221, 224, 227, 0.4),
                          labelText: 'Remind'),
                      keyboardType: TextInputType.datetime,
                      onSaved: (value) {
                        print(value);
                        // _editedProduct = Product(
                        //   title: _editedProduct.title,
                        //   price: _editedProduct.price,
                        //   description: value,
                        //   imageUrl: _editedProduct.imageUrl,
                        //   id: _editedProduct.id,
                        //   isFavorite: _editedProduct.isFavorite,
                        // );
                      },
                    ),
                    Center(
                      child: RaisedButton(
                          onPressed: () {
                            DatePicker.showDateTimePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2018),
                                maxTime: DateTime(2222),
                                onChanged: (date) {}, onConfirm: (date) async {
                              setState(() {
                                _updateNotifyDateTime(date);
                              });

                              // scheduleNotificationReminder(
                              //     flutterLocalNotificationsPlugin, date);
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.pl);
                          },
                          child: Text(
                            'Pick date',
                            style: TextStyle(color: Colors.blue),
                          )),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
