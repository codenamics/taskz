import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tazks/provider/Task.dart';
import 'package:tazks/provider/Tasks.dart';
import 'package:tazks/screens/MainTasksScreen.dart';

class EditTaskScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _form = GlobalKey<FormState>();

  DateTime dateTime;
  var _editedTask =
      Task(id: null, title: '', description: '', isCompleted: false);
  var _initValues = {'title': '', 'description': ''};
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final taskId = ModalRoute.of(context).settings.arguments as String;

      if (taskId != null) {
        _editedTask =
            Provider.of<Tasks>(context, listen: false).findById(taskId);
        print(_editedTask.id);

        _initValues = {
          'title': _editedTask.title,
          'description': _editedTask.description,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
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

    if (_editedTask.id != null) {
      print(_editedTask.id);
      Provider.of<Tasks>(context, listen: false)
          .updateTask(_editedTask.id, _editedTask);
      Navigator.of(context).pushNamed(MainTasksScreen.routeName);
    } else {
      try {
        Provider.of<Tasks>(context, listen: false).addTask(_editedTask);
        Navigator.of(context).pop();
      } catch (e) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.of(ctx).pushNamed(MainTasksScreen.routeName);
                },
              )
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: const CircularProgressIndicator(),
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
                        _editedTask = Task(
                            id: _editedTask.id,
                            title: value,
                            description: _editedTask.description,
                            isCompleted: _editedTask.isCompleted);
                      },
                    ),
                  const  SizedBox(
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
                        _editedTask = Task(
                            id: _editedTask.id,
                            title: _editedTask.title,
                            description: value,
                            isCompleted: _editedTask.isCompleted);
                      },
                    ),
                   const SizedBox(
                      height: 40,
                    ),
                    RaisedButton(
                      color: Colors.blueAccent,
                      onPressed: _saveForm,
                      child: const Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Add Task',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
