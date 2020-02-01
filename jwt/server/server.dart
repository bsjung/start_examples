import 'dart:convert';
import 'package:start/start.dart';
import 'package:logging/logging.dart';
import 'package:start_jwt/json_web_token.dart';

String my_secret = "My secret key";

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  start(port: 3000).then((Server app) {

    app.static('web', jail: false);

    app.post('/auth').listen((req) {
      //print (req.header('Content-Type'));
      req.payload().then((data) {
        print (data);
        final jwt = new JsonWebTokenCodec(secret: my_secret);
        var today = new DateTime.now();
        var until = today.add(new Duration(hours: 4));
        final payload = {
          'name': data['email'],
          'exp': until.millisecondsSinceEpoch,
        };
        final token = jwt.encode(payload);
        var msg = {};
        msg['token'] = token;
        msg['payload'] = payload;
        req.response
          .header('Content-Type', 'application/json')
          .send(jsonEncode(msg));
      });
    });

  });

}
