/*
 * Project: Xtronic Dev Tools
 * File Name: data_streamer_model.dart
 * File Created: Thursday, 18th January 2024 10:22:40 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:31:29 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'package:serial/serial.dart';

class DataStreamerModel {
  COMPortModel? comPortModel;

  DataStreamerModel.comPortModel(String comPort) {
    comPortModel = COMPortModel(comPort);
  }
}

class COMPortModel {
  String portName;
  SerialPort? port;
  COMPortModel(this.portName);
}
