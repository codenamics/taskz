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
                      const SizedBox(
                        height: 12,
                      ),
                      const Icon(
                        Icons.texture,
                        size: 50,
                        color: Colors.lightBlueAccent,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Tazks',
                        textAlign: TextAlign.left,
                        style: loginHeader,
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text('We missed you',
                          textAlign: TextAlign.left, style: loginSubHeader),
                      const SizedBox(
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
                              labelStyle: const TextStyle(fontSize: 18),
                              labelText: 'Email'),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'This field cannot be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          onSaved: (input) => _password = input,
                          decoration: InputDecoration(
                              labelStyle: const TextStyle(fontSize: 18),
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
                  GestureDetector(
                    onTap: () {
                      _submit();
                    },
                    child: Container(
                        child: Center(
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 30,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        height: 60,
                        width: 200,
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text(
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
                          child: const Text(
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
