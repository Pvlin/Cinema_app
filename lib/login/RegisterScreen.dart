import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cinema_app/storages/UserData.dart';
import 'package:cinema_app/screens/supporting/Navigation.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static const String id = 'RegisterSreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final UserData _userData = UserData();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  late bool card = false;
  late String _email;
  late String _password;
  late String _name;
  late String _surName;

  late bool _allow = false;

  void checkAllow() {
    if ((_email != null) &&
        (_password != null) &&
        (_name != null) &&
        (_surName != null)) {
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
                                _email = input;
                                checkAllow();
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
                          SizedBox(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Imię',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: TextField(
                              onChanged: (input) {
                                _name = input;
                                checkAllow();
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Nazwisko',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: TextField(
                              onChanged: (input) {
                                _surName = input;
                                checkAllow();
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Specjalne uprawnienia',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  card = !card;
                                });
                              },
                              child: card
                                  ? const Icon(Icons.local_play,
                                      color: Colors.black)
                                  : const Icon(Icons.close,
                                      color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      _allow
                          ? RaisedButton(
                              onPressed: () async {
                                _userData.saveLogged(true);
                                try {
                                  final newUser = await _auth
                                      .createUserWithEmailAndPassword(
                                          email: _email, password: _password);
                                  _firestore
                                      .collection('userData')
                                      .doc(_email)
                                      .set({
                                    'name': _name,
                                    'surname': _surName,
                                    'card': card
                                  });
                                  if (newUser != null) {
                                    _userData.saveEmail(_email);
                                    _userData.savePassword(_password);

                                    Navigator.pushNamed(context, Navigation.id);
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: const Text('Zarejestruj'),
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
