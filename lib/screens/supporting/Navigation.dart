import 'package:flutter/material.dart';
import 'package:cinema_app/screens/HomeScreen.dart';
import 'package:cinema_app/screens/CardScreen.dart';
import 'package:cinema_app/screens/SettingsScreen.dart';
import 'package:cinema_app/storages/UserData.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  static const id = 'Navigation';

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 1;
  List<Widget> pages = [const CardScreen(), HomeScreen(), const SettingsScreen()];

  final UserData _userData = UserData();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _email = '';
  String _password = '';

  void updateEmail(String email) {
    setState(() {
      this._email = email;
    });
  }

  void updatePassword(String password) {
    setState(() {
      this._password = password;
    });
  }

  void tryLogIn(String email, String password) async {
    if (email != '' && password != '') {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        print('Zalogowano');
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    _userData.getEmail().then((value) => updateEmail);
    _userData.getPassword().then((value) => updatePassword);
    tryLogIn(_email, _password);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('KINO'),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.blueGrey,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                child: Icon(
                  Icons.local_play,
                  size: _selectedIndex == 0 ? 35 : 25,
                  color: _selectedIndex == 0 ? Colors.white : Colors.grey,
                ),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                child: Icon(
                  Icons.home,
                  size: _selectedIndex == 1 ? 35 : 25,
                  color: _selectedIndex == 1 ? Colors.white : Colors.grey,
                ),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
                child: Icon(
                  Icons.settings,
                  size: _selectedIndex == 2 ? 35 : 25,
                  color: _selectedIndex == 2 ? Colors.white : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
