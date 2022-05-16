import 'package:flutter/material.dart';
import 'screens/supporting/Navigation.dart';
import 'screens/HomeScreen.dart';
import 'screens/CardScreen.dart';
import 'screens/SettingsScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login/LogRegScreen.dart';
import 'login/LogInScreen.dart';
import 'login/RegisterScreen.dart';
import 'package:cinema_app/storages/UserData.dart';

UserData _userData = UserData();
Widget _defaultHome = LogRegScreen();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool? _result = await _userData.getLogged();
  if (_result == true) {
    _defaultHome = Navigation();
  }
  await Firebase.initializeApp();     //Do sprawdzenia czy potrzebne!
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _defaultHome,
      routes: {
        Navigation.id: (context) => Navigation(),
        HomeScreen.id: (context) => HomeScreen(),
        CardScreen.id: (context) => CardScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
        LogRegScreen.id: (context) => LogRegScreen(),
        LogInScreen.id: (context) => LogInScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
      },
    );
  }
}
