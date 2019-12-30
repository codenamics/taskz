import 'package:flutter/material.dart';
import 'package:tazks/constant/colors.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 7,
                  ),
                  Icon(
                    Icons.texture,
                    size: 50,
                    color: Colors.blueAccent,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    'Tazks',
                    textAlign: TextAlign.left,
                    style: loginHeader,
                  ),
                  SizedBox(
                    height: 20,
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
              Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: 18),
                          labelText: 'Email'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: 18),
                          labelText: 'Password'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
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
              Column(
                children: <Widget>[
                  FlatButton(
                    color: Color.fromRGBO(110, 121, 139, 0.2),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          letterSpacing: 2,
                          fontSize: 37,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(55, 66, 77, 1)),
                    ),
                    onPressed: () {},
                  ),
                ],
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
    );
  }
}
