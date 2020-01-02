import 'package:flutter/material.dart';
import 'package:tazks/constant/colors.dart';
import 'package:tazks/screens/MainTasksScreen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.of(context).pushNamed(MainTasksScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 12,
                      ),
                      Icon(
                        Icons.texture,
                        size: 50,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Tazks',
                        textAlign: TextAlign.left,
                        style: loginHeader,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text('We missed you',
                          textAlign: TextAlign.left, style: loginSubHeader),
                      SizedBox(
                        height: 10,
                      ),
                      Text('There is much to be done...',
                          textAlign: TextAlign.left, style: loginSubHeader),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1 / 1.4,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          onSaved: (input) => _email = input,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(fontSize: 18),
                              labelText: 'Email'),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'This field cannot be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          onSaved: (input) => _password = input,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(fontSize: 18),
                              labelText: 'Password'),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'This field cannot be empty';
                            }
                            if (value.length < 6) {
                              return 'Password needs to be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1 / 1.4,
                  ),
                  FlatButton(
                    color: Color.fromRGBO(110, 121, 139, 0.2),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          letterSpacing: 2,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(55, 66, 77, 1)),
                    ),
                    onPressed: () {
                      _submit();
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Need account?',
                        style: TextStyle(
                            color: Color.fromRGBO(110, 121, 139, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                          ),
                          child: Text(
                            'SignUp',
                            style: TextStyle(
                                letterSpacing: 1,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(55, 66, 77, 1)),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
