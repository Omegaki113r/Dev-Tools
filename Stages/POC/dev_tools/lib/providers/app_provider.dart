import 'package:flutter/material.dart';

enum SelectedView { TYPE_CONVERTER, STREAMER }

class AppProvider with ChangeNotifier {

  SelectedView selectedView = SelectedView.TYPE_CONVERTER;
}
