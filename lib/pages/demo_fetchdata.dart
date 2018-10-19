// https://flutter.io/cookbook/networking/fetch-data/

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DemoPageState();
  }
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('fetch data demo'),
        backgroundColor: Colors.blue,
      ),
      body: new Column(
        children: <Widget>[
          new CircularProgressIndicator(),
          new Center(
            child: FutureBuilder<Post>(
              future: fetchPost(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return new Text(snapshot.data.title);
                } else if (snapshot.hasError) {
                  return new Text('${snapshot.error}');
                }
                return new CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<Post> fetchPost() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/posts/2');
  if (response.statusCode == 200) {
    return Post.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
