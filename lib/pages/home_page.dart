import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

// import '../util/net-util.dart';
import '../pages/sidebar_page.dart';
import '../models/topic.dart';


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<Topic> tl;
  static const pageSize = 20;

  @override
  void initState() {
    super.initState();
    _getBlogList(1);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<Topic>> fetchData(int pageNum) async {
    List<Topic> topicList;
    String topicUrl = 'https://cnodejs.org/api/v1/topics?limit=$pageSize&page=$pageNum&tab=all';
    final response = await http.get(topicUrl);
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      for (var item in body) {
        Topic t = Topic.fromJson(json.decode(item));
        topicList.add(t);
      }

    } else {
      throw Exception('Failed to load topic');
    }
    return topicList;
  }

  static dynamic _getBlogList(int pageNum) async {
    print('pageNum = $pageNum');
    String topicUrl = 'https://cnodejs.org/api/v1/topics?limit=$pageSize&page=$pageNum&tab=all';
    http.Response response = await http.get(topicUrl);
    Map<String, dynamic> body = json.decode(response.body);
    // topicList = body['data'];
    return body['data'];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('CNode'),
        backgroundColor: Colors.blue,
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new ListTile(
              title: new Text('全部'),
              leading: new Icon(Icons.menu),
              onTap: () {
                Navigator.of(context).pop();
                // Navigator.of(context).push(
                //   new MaterialPageRoute(
                //     builder: (BuildContext build) {
                //       return new SidebarPage('全部');
                //     },
                //   ),
                // );
              },
            ),
            new ListTile(
              title: new Text('精华'),
              leading: new Icon(Icons.thumb_up),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext build) {
                      return new SidebarPage('精华');
                    },
                  ),
                );
              },
            ),
            new ListTile(
              title: new Text('分享'),
              leading: new Icon(Icons.share),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext build) {
                      return new SidebarPage('分享');
                    },
                  ),
                );
              },
            ),
            new ListTile(
              title: new Text('问答'),
              leading: new Icon(Icons.question_answer),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext build) {
                      return new SidebarPage('问答');
                    },
                  ),
                );
              },
            ),
            new ListTile(
              title: new Text('招聘'),
              leading: new Icon(Icons.group),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext build) {
                      return new SidebarPage('招聘');
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: new ListView.builder(
        itemCount: topicList.length + 1,
        itemBuilder: (BuildContext context, int index) => _buildRow(index),
      ),
    );
  }

  Widget _buildRow(int index) {
    print(index);
    if (topicList == null || topicList.length == 0) {
      return null;
    }
    return new Container(
      child: new Text(topicList[index]['title']),
    );
  }
}
