/*
 * Project: Xtronic Dev Tools
 * File Name: serial_interface.dart
 * File Created: Thursday, 25th January 2024 6:33:45 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:29:52 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'package:dev_tools/core/services/data_streamer/serial/serial_stub.dart'
    if (dart.library.io) 'package:dev_tools/core/services/data_streamer/serial/desktop_serial.dart'
    if (dart.library.html) 'package:dev_tools/core/services/data_streamer/serial/web_serial.dart';
import 'package:flutter/foundation.dart';

abstract class SerialInterface {
  factory SerialInterface() => getSerialInterface();
  void dispose();
  bool fetchPortList();
  bool connect(String selectedBaudrate, String selectedDataBits, String selectedParity, String selectedStopBits, bool ctsFlowControl);
  bool disconnect();
  void setBaudrate(String newBaudrate);
  void setDatabits(String newDatabits);
  void setStopbits(String newStopbits);
  void setParity(String newParity);
  String get name;
  bool get isOpen;
  Stream? get reader;
  get port;
  set port(dynamic port);
  get portNameList;
  get portList;
  List<String> get baudrateList;
  List<String> get dataBitList;
  List<String> get stopBitList;
  List<String> get parityList;

  write(Uint8List bytesToWrite);
}
