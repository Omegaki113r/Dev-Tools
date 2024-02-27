/*
 * Project: Xtronic Dev Tools
 * File Name: streamer_provider.dart
 * File Created: Friday, 26th January 2024 12:58:37 am
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:31:51 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

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
