/*
 * Project: Xtronic Dev Tools
 * File Name: app_provider.dart
 * File Created: Wednesday, 3rd January 2024 5:41:32 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:29:43 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'package:dev_tools/core/constants/app_constants.dart';
import 'package:flutter/material.dart';



class AppProvider with ChangeNotifier {
  SelectedView selectedView = SelectedView.bitwiseCalculator;
}
