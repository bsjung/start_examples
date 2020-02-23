import 'package:flutter/material.dart';
import 'home.dart';

void main() => runApp(GalleryApp());

class GalleryApp extends StatefulWidget {
  GalleryApp({Key key}) : super(key: key);
  @override
  GalleryAppState createState() => new GalleryAppState();
}

class GalleryAppState extends State<GalleryApp> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'start_chart Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Home(),
    );
  }
}
