import 'package:flutter/material.dart';

class SidebarPage extends StatelessWidget {
  final String pageText;

  SidebarPage(this.pageText);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(pageText),
      ),
      body: new Text(pageText),
    );
  }
}
