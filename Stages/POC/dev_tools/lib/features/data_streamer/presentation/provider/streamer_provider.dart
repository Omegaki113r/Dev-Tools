import 'package:flutter/foundation.dart';

class StreamerProvider with ChangeNotifier {
  bool _autoScroll = true;

  List<String> asciiList = [];
  List<String> hexList = [];
  List<String> decimalList = [];
  List<String> binaryList = [];

  StreamerProvider();

  bool get autoScroll => _autoScroll;
  set autoScroll(bool value) {
    _autoScroll = value;
    notifyListeners();
  }
}
