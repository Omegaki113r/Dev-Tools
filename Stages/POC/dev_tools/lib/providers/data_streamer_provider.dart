import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:logger/logger.dart';

class DataStreamerProvider with ChangeNotifier {
  Logger _logger = Logger(printer: SimplePrinter());
  DeepCollectionEquality _equalityChecker = DeepCollectionEquality();
  Map<String, SerialPort?> portList = {};
  SerialPort? _selectedPort;

  DataStreamerProvider() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      List<String> _portNameList = SerialPort.availablePorts;
      Map<String, SerialPort?> _portMap = {};
      for (String portName in _portNameList) {
        _portMap.addAll({portName: null});
      }
      if (!_equalityChecker.equals(portList, _portMap)) {
        portList = _portMap;
        notifyListeners();
      }
    });
  }

  void selectedSerialPortChanged(value) {
    print(value);
    // if (_selectedPort == null) {
    //   _selectedPort = SerialPort(value);
    //   SerialPortConfig config = _selectedPort!.config;
    //   config.baudRate = 115200;
    //   config.bits = 8;
    //   config.parity = 0;
    //   config.stopBits = 1;
    //   _selectedPort!.config = config;
    //   bool openState = _selectedPort!.open(mode: SerialPortMode.readWrite);
    //   if (!openState) {
    //     bool closeState = _selectedPort!.close();
    //     openState = _selectedPort!.open(mode: SerialPortMode.readWrite);
    //   }
    //   SerialPortReader serialPortReader = SerialPortReader(_selectedPort!);
    //   Stream incomingDataStream = serialPortReader.stream.asyncMap((data) {
    //     return String.fromCharCodes(data);
    //   });
    //   incomingDataStream.listen((data) {
    //     // print(data);
    //     // _logger.i(data);
    //   });
    // } else if (_selectedPort != null && !_selectedPort!.isOpen) {
    //   _selectedPort = SerialPort(value);
    //   SerialPortConfig config = _selectedPort!.config;
    //   config.baudRate = 115200;
    //   config.bits = 8;
    //   config.parity = 0;
    //   config.stopBits = 1;
    //   _selectedPort!.config = config;
    //   _selectedPort!.open(mode: SerialPortMode.readWrite);
    //   SerialPortReader serialPortReader = SerialPortReader(_selectedPort!);
    //   Stream incomingDataStream = serialPortReader.stream.asyncMap((data) {
    //     return String.fromCharCodes(data);
    //   });
    //   incomingDataStream.listen((data) {
    //     print(data);
    //   });
    // }
  }
}
