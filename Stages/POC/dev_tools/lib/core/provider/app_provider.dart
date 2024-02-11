import 'package:dev_tools/core/constants/app_constants.dart';
import 'package:flutter/material.dart';



class AppProvider with ChangeNotifier {
  SelectedView selectedView = SelectedView.bitwiseCalculator;
}
