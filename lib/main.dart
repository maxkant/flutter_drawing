import 'package:flutter/material.dart';
import 'draw.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Draw!',
      theme: new ThemeData(
        primaryColor: Colors.lightGreen,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Center(
            child: new Text('Draw'),
          ),
        ),
        body: new DrawComponent(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
