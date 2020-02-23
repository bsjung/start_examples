
import 'package:flutter/material.dart';
import 'package:start_chart/start_chart.dart';
import '../gallery.dart';

List<GalleryScaffold> buildGallery() {

  return [
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.insert_chart),
      title: 'Simple Pie Chart',
      subtitle: 'Simple pie chart with percentage',
      childBuilder: () => new PieChart(percentage: 55),
    ),
  ];
}
