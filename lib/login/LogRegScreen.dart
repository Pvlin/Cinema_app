import 'package:cinema_app/login/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:cinema_app/login/LogInScreen.dart';

class LogRegScreen extends StatelessWidget {
  const LogRegScreen({Key? key}) : super(key: key);

  static const String id = 'log_reg_screen';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Masz już konto?',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: 250,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(15),
              ),
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, LogInScreen.id);
                },
                child: const Text(
                  'Zaloguj',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'lub',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: 250,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(15),
              ),
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegisterScreen.id);
                },
                child: const Text(
                  'Zarejestruj',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
