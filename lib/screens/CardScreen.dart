import 'package:flutter/material.dart';
import 'package:cinema_app/storages/UserData.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  static const id = 'CardScreen';

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text('//TODO Ekran karty użytownika oraz bietów');
  }
}
