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
  String title;
  String buttonText;
  DateTime dateTime;
  var _editedTask =
      Task( title: '', description: '', isCompleted: false);
  var _initValues = {'title': '', 'description': ''};
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {

      final taskId = ModalRoute.of(context).settings.arguments as String;
    
      if (taskId != null) {
         title = 'Edit Task';
         buttonText = 'Save task';
        _editedTask =
            Provider.of<Tasks>(context, listen: false).findById(taskId);
  

        _initValues = {
          'title': _editedTask.title,
          'description': _editedTask.description,
        };
      }else{
        title = 'New Task';
        buttonText = 'Add Task';
      }

  
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
  
      Provider.of<Tasks>(context, listen: false)
          .updateTask(_editedTask.id, _editedTask);
      Navigator.of(context).pushReplacementNamed(MainTasksScreen.routeName);
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
        leading: IconButton(icon: Icon(Icons.chevron_left), color: Colors.black, onPressed: (){
          Navigator.of(context).pop();
        },),
        backgroundColor: Colors.white,
        title:  Text(title, style: TextStyle(color: Colors.black),),
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
                          fillColor: Color.fromRGBO(233, 240, 245, 1),
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
                            reminderDate: _editedTask.reminderDate,
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
                          fillColor: Color.fromRGBO(233, 240, 245, 1),
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
                            reminderDate: _editedTask.reminderDate,
                            description: value,
                            isCompleted: _editedTask.isCompleted);
                      },
                    ),
                   const SizedBox(
                      height: 40,
                    ),
                       GestureDetector(
                    onTap: _saveForm,
                    child: Container(
                        child: Center(
                          child:  Text(
                            buttonText,
                            style: TextStyle(
                              fontSize: 24,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(182, 226, 246, 1),
                                  spreadRadius: 3,
                                  blurRadius: 15,
                                  offset: Offset(0, 0)),
                            ],
                            color: Colors.lightBlueAccent.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Color.fromRGBO(223, 223, 223, 0),
                                width: 0))),
                  ),
                  ],
                ),
              ),
            ),
    );
  }
}
