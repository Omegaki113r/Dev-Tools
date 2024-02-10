import 'package:flutter/material.dart';

enum SelectedView { bitwiseCalculator, streamer }

class AppProvider with ChangeNotifier {
  SelectedView selectedView = SelectedView.bitwiseCalculator;
}
