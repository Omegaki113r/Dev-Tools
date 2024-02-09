import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class StreamerProvider with ChangeNotifier {
  final Logger _logger = Logger(printer: SimplePrinter());
  bool _autoScroll = true;

  List<String> ascii_list = [];
  List<String> hex_list = [];
  List<String> decimal_list = [];
  List<String> binary_list = [];

  StreamerProvider() {}

  bool get autoScroll => _autoScroll;
  set autoScroll(bool value) {
    _autoScroll = value;
    notifyListeners();
  }
}
