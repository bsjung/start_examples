
import 'package:flutter/material.dart';
import 'package:start_chart/start_chart.dart';
import '../gallery.dart';

List<GalleryScaffold> buildGallery() {
  List<double> points = [
    50, 90, 1003, 500, 150, 120, 200, 80
  ];

  List<String> labels = [
    "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020"
  ];

  Size size = Size(300, 300);

  return [
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.insert_chart),
      title: 'Simple Bar Chart',
      subtitle: 'bar chart with labels',
      childBuilder: () => new BarChart(size : size, data: points, labels: labels),
    ),
  ];
}
