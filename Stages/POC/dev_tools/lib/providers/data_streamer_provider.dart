import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:logger/logger.dart';

class DataStreamerProvider with ChangeNotifier {
  final Logger _logger = Logger(printer: SimplePrinter());
  Map<String, SerialPort?> portList = {};
  SerialPort? _selectedPort;
  SerialPortReader? _serialPortReader;
  Stream? _incomingDataStream;
  String serialData = "";
  DataStreamerProvider() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      List<String> portNameList = SerialPort.availablePorts;
      for (String portName in portNameList) {
        if (!portList.keys.contains(portName)) {
          portList[portName] = null;
          notifyListeners();
        }
      }
    });
  }

  void serialPortConnect() {
    if (_selectedPort != null && !_selectedPort!.isOpen) {
      SerialPortConfig config = _selectedPort!.config;
      config.baudRate = 115200;
      config.bits = 8;
      config.parity = 0;
      config.stopBits = 1;
      _selectedPort!.config = config;
      bool openState = _selectedPort!.openReadWrite();
      if (openState) {
        try {
          _serialPortReader = SerialPortReader(_selectedPort!);
          _incomingDataStream = _serialPortReader!.stream.asyncMap((data) {
            return String.fromCharCodes(data);
          });
          _incomingDataStream!.listen((data) {
            serialData += data;
            // print(data);
            // _logger.i(data);
            notifyListeners();
          });
          notifyListeners();
        } on SerialPortError catch (err, _) {
          print(SerialPort.lastError);
          _selectedPort!.close();
        }
      } else {
        _serialPortReader!.close();
        bool closeState = _selectedPort!.close();
      }
    }
  }

  void serialPortDisconnect() {
    if (_selectedPort != null && _selectedPort!.isOpen) {
      _serialPortReader!.close();
      bool closeState = _selectedPort!.close();
      if (closeState) {
        notifyListeners();
      }
    }
  }

  void selectedSerialPortChanged(value) {
    if (_selectedPort == null) {
      _selectedPort = SerialPort(value);
    } else if (value != _selectedPort!.name) {
      _selectedPort = SerialPort(value);
    }
    if (_selectedPort != null) {
      portList.update(value, (value) => _selectedPort);
    }
  }

  SerialPort? get port => _selectedPort;
}
