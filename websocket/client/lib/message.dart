import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. 
//// [message] does _not_ depend on Provider.
class Message with ChangeNotifier {
  String _msg = '';

  String get msg => _msg;

  void setMsg(String data) {
    _msg = data;
    print ("[DEBUG] data : " + data);
    print ("[DEBUG] _msg : " + _msg);
    notifyListeners();
  }
}
