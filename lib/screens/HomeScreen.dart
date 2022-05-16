import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cinema_app/widgets/MovieTile.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Repertuar'),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('movies').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final cards = snapshot.data!.docs;
                  List<CircleAvatar> cardWidgets = [];

                  for (var card in cards) {
                    final name = card['name'].toString();
                    final url = card['image'].toString();
                    var now = DateTime.now();
                    final date = card['date'].toDate();
                    final diff = now.difference(date).inSeconds;
                    if (diff > 0) {
                      final cardWidget = CircleAvatar(
                        radius: 75,
                        backgroundColor: Colors.blueGrey,
                        child: Text(name),
                      );
                      cardWidgets.add(cardWidget);
                    }
                  }
                  return Expanded(
                    flex: 2,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: cardWidgets,
                    ),
                  );
                }
                return const Text('Brak filmów');
              },
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Zobacz już wkrótce'),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('movies').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final cards = snapshot.data!.docs;
                  List<CircleAvatar> cardWidgets = [];

                  for (var card in cards) {
                    final name = card['name'].toString();
                    var now = DateTime.now();
                    final date = card['date'].toDate();
                    final diff = now.difference(date).inSeconds;
                    if (diff < 0) {
                      final cardWidget = CircleAvatar(
                        radius: 75,
                        backgroundColor: Colors.blueGrey,
                        child: Text(name),
                      );
                      cardWidgets.add(cardWidget);
                    }
                  }
                  return Expanded(
                    flex: 2,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: cardWidgets,
                    ),
                  );
                }
                return const Text('Brak filmów');
              },
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Zobacz przedpremierowo!'),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('movies').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final cards = snapshot.data!.docs;
                  List<CircleAvatar> cardWidgets = [];

                  for (var card in cards) {
                    final name = card['name'].toString();
                    var now = DateTime.now();
                    final date = card['date'].toDate();
                    final early = card['early'];
                    final diff = now.difference(date).inSeconds;
                    if (diff < 0 && early) {
                      final cardWidget = CircleAvatar(
                        radius: 75,
                        backgroundColor: Colors.blueGrey,
                        child: Text(name),
                      );
                      cardWidgets.add(cardWidget);
                    }
                  }
                  return Expanded(
                    flex: 2,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: cardWidgets,
                    ),
                  );
                }
                return const Text('Brak filmów');
              },
            ),
          ],
        ),
      ),
    );
  }
}
