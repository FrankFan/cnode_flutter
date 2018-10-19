import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PhotoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PhotoListState();
  }
}

class _PhotoListState extends State<PhotoList> {
  StreamController<Photo> streamController;
  List<Photo> list = [];

  @override
  void initState() {
    super.initState();
    streamController = StreamController.broadcast();

    streamController.stream.listen((p) => setState(() => list.add(p)));

    load(streamController);
  }

  load(StreamController<Photo> sc) async {
    String photoUrl =
        'https://jsonplaceholder.typicode.com/photos';
    var client = new http.Client();
    var req = new http.Request('get', Uri.parse(photoUrl));
    var streamedRes = await client.send(req);

    streamedRes.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .expand((e) => e)
        .map((map) => Photo.fromJsonMap(map))
        .pipe(sc);
    print(sc);
  }

  @override
  void dispose() {
    super.dispose();
    streamController?.close();
    streamController = null;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('load more demo'),
        backgroundColor: Colors.blue,
      ),
      body: new Center(
        child: new ListView.builder(
          itemBuilder: (BuildContext context, int index) => _makeElement(index),
        ),
      ),
    );
  }

  Widget _makeElement(int index) {
    if (index >= list.length) {
      return null;
    }
    return new Container(
      padding: new EdgeInsets.all(5.0),
      child: new Padding(
        padding: new EdgeInsets.only(top: 10.0),
        child: new Column(
          children: <Widget>[
            new Image.network(list[index].url),
            new Text(list[index].title),
          ],
        ),
      ),
    );
  }
}

class Photo {
  final String title;
  final String url;

  Photo.fromJsonMap(Map map)
      : title = map['title'],
        url = map['url'];
}