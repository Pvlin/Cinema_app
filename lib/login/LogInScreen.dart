import 'package:flutter/material.dart';
import 'package:cinema_app/storages/UserData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cinema_app/screens/supporting/Navigation.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  static const String id = 'log_in_screen';

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final UserData _userData = UserData();
  final _auth = FirebaseAuth.instance;

  late bool card = false;
  late String _email;
  late String _password;

  late bool _allow;

  void checkAllow() {
    if ((_email != null) && (_password != null)) {
      setState(() {
        _allow = true;
      });
    } else {
      setState(() {
        _allow = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: TextField(
                              onChanged: (input) {
                                setState(() {
                                  _email = input;
                                  checkAllow();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Hasło',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            ),
                          ),
                          Container(
                            width: 100,
                            child: TextField(
                              obscureText: true,
                              onChanged: (input) {
                                _password = input;
                                checkAllow();
                              },
                            ),
                          ),
                        ],
                      ),
                      _allow
                          ? RaisedButton(
                              onPressed: () async {
                                try {
                                  _auth.signInWithEmailAndPassword(
                                      email: _email, password: _password);
                                  _userData.saveEmail(_email);
                                  _userData.savePassword(_password);
                                  _userData.saveLogged(true);
                                  Navigator.pushNamed(context, Navigation.id);
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: Text('Zaloguj'),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
