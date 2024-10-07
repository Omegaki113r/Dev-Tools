/*
 * Project: Xtronic Dev Tools
 * File Name: serial_service.dart
 * File Created: Saturday, 10th February 2024 4:02:35 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:30:04 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'package:dev_tools/core/services/data_streamer/serial/serial_interface.dart';
import 'package:flutter/foundation.dart';

class SerialService {
  final SerialInterface _serialInterface = SerialInterface();

  get reader => _serialInterface.reader;

  get port => _serialInterface.port;

  get portList => _serialInterface.portList;

  set port(port) {
    _serialInterface.port = port;
  }

  void dispose() {
    _serialInterface.dispose();
  }

  bool fetchPortList() {
    return _serialInterface.fetchPortList();
  }

  Future<bool> connect(String selectedBaudrate, String selectedDataBits,
      String selectedParity, String selectedStopBits, bool ctsFlowControl) {
    return _serialInterface.connect(selectedBaudrate, selectedDataBits,
        selectedParity, selectedStopBits, ctsFlowControl);
  }

  bool get isConnected => _serialInterface.isConnected;

  bool disconnect() {
    return _serialInterface.disconnect();
  }

  void setBaudrate(String newBaudrate) {
    _serialInterface.setBaudrate(newBaudrate);
  }

  void setDatabits(String newDatabits) {
    _serialInterface.setDatabits(newDatabits);
  }

  void setStopbits(String newStopbits) {
    _serialInterface.setStopbits(newStopbits);
  }

  void setParity(String newPairty) {
    _serialInterface.setParity(newPairty);
  }

  List<String> get baudrateList => _serialInterface.baudrateList;
  List<String> get dataBitList => _serialInterface.dataBitList;
  List<String> get stopBitList => _serialInterface.stopBitList;
  List<String> get parityList => _serialInterface.parityList;

  void write(Uint8List bytesToWrite) => _serialInterface.write(bytesToWrite);

  void ctsFlowControl(bool ctsFlowControl) =>
      _serialInterface.ctsFlowControl(ctsFlowControl);
}
