
import 'package:flutter/material.dart';
import 'package:start_chart/start_chart.dart';
import '../gallery.dart';

List<GalleryScaffold> buildGallery() {

  Size size = Size(450, 450);
  return [
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.insert_chart),
      title: 'Simple Pie Chart',
      subtitle: 'Simple pie chart with percentage',
      childBuilder: () => new PieChart(size: size, percentage: 55),
    ),
  ];
}
