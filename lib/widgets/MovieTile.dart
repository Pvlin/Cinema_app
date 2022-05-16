import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';




class MovieTile extends StatefulWidget {

  final String url;
  final String title;

  const MovieTile({Key? key, required this.url, required this.title}) : super(key: key);


  @override
  _MovieTileState createState() => _MovieTileState();
}

class _MovieTileState extends State<MovieTile> {


    late String image;


    Future downloadImage() async {
      Reference _ref = FirebaseStorage
          .instance
          .ref()
          .child(widget.url);
      String downloadedURL = await _ref.getDownloadURL();

      setState(() {
         image = downloadedURL;
      });
    }

  @override
  void initState() {
    downloadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        child: SizedBox(
          child: Align(alignment: Alignment.topLeft,
          child: Image.network(image),
          ),
          width: MediaQuery.of(context).size.width / 4,
        ),
      ),
    );
  }
}
