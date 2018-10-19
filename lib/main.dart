import 'package:flutter/material.dart';

import './pages/home_page.dart';
// import './pages/demo_fetchdata.dart';
// import './pages/demo_loadmore.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new HomePage(),
      // home: new PhotoList(),
      // home: new DemoPage(),
    );
  }
}
