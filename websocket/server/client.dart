// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

main() async {
  final channel = await IOWebSocketChannel.connect("ws://localhost:3000/socket");

  var data = jsonEncode( {'name':'bsjung'} );
  channel.sink.add(data);
  channel.stream.listen((msg) {
    print (msg);
  }, onDone: () => print("Stream is closed"));
}
