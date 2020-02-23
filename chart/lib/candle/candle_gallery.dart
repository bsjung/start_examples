import 'package:flutter/material.dart';
import '../gallery.dart';
import './demo.dart';

List<GalleryScaffold> buildGallery() {

  return [
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.insert_chart),
      title: 'Candle Chart',
      subtitle: 'Candle chart with bitcoin datas',
      childBuilder: () => new Demo(),
    ),
  ];
}

