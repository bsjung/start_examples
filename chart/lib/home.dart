import 'package:flutter/material.dart';
import 'package:start_chart/start_chart.dart';

import 'bar/bar_gallery.dart' as bar show buildGallery;
import 'line/line_gallery.dart' as line show buildGallery;
import 'pie/pie_gallery.dart' as pie show buildGallery;
import 'candle/candle_gallery.dart' as candle show buildGallery;

class Home extends StatelessWidget {
  final barGalleries = bar.buildGallery();
  final candleGalleries = candle.buildGallery();
  final lineGalleries = line.buildGallery();
  final pieGalleries = pie.buildGallery();

  @override
  Widget build(BuildContext context) {
    var galleries = <Widget> [];

    // Add bar examples
    galleries.addAll(
        barGalleries.map((gallery) => gallery.buildGalleryListTile(context)));

    // Add candle examples
    galleries.addAll(
        candleGalleries.map((gallery) => gallery.buildGalleryListTile(context)));

    // Add line examples
    galleries.addAll(
        lineGalleries.map((gallery) => gallery.buildGalleryListTile(context)));

    // Add pie examples
    galleries.addAll(
        pieGalleries.map((gallery) => gallery.buildGalleryListTile(context)));

    return Scaffold(
      appBar: AppBar(
        title: Text("start_chart Gallery Page"),
      ),
      body: new ListView(children: galleries),
    );
  }
}
