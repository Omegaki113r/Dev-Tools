import 'dart:async';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'package:flutter_libserialport/flutter_libserialport.dart'
    if (dart.library.html) 'package:serial/serial.dart';

import 'package:dev_tools/interfaces/Iserial.dart';

class StreamerProvider with ChangeNotifier {
  final Logger _logger = Logger(printer: SimplePrinter());
  bool _autoScroll = true;
  SerialPortReader? _serialPortReader;
  Stream? _incomingDataStream;
  List<String> serialData = [];

  List<String> ascii_list = [];
  List<String> hex_list = [];
  List<String> decimal_list = [];
  List<String> binary_list = [];

  SerialPort? _selectedPort;
  Map<String, SerialPort?> portList = {};
  String? _selectedBaudrate = "115200";
  List<String> baudList = [
    "300",
    "600",
    "1200",
    "2400",
    "4800",
    "9600",
    "14400",
    "19200",
    "28800",
    "38400",
    "56000",
    "57600",
    "115200",
    "128000",
    "256000"
  ];
  String? _selectedDataBits = "8";
  List<String> dataBits = [
    "5",
    "6",
    "7",
    "8",
  ];
  String? _selectedStopBits = "1";
  List<String> stopBits = [
    "1",
    "1.5",
    "2",
  ];
  String? _selectedParity = "None";
  List<String> parity = [
    "None",
    "Odd",
    "Even",
    "Mark",
    "Space",
  ];

  StreamerProvider() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      List<String> portNameList = SerialPort.availablePorts;
      if (portNameList.isEmpty && portList.isNotEmpty) {
        portList.clear();
        notifyListeners();
      }
      for (String portName in portNameList) {
        if (!portList.keys.contains(portName)) {
          portList[portName] = SerialPort(portName);
          notifyListeners();
        }
        _selectedPort ??= portList.values.first;
      }
    });
  }

  void serialPortConnect() {
    if (_selectedPort != null && !_selectedPort!.isOpen) {
      bool openState = _selectedPort!.openReadWrite();
      if (openState) {
        SerialPortConfig config = _selectedPort!.config;
        config.baudRate = 115200;
        config.bits = 8;
        config.parity = 0;
        config.stopBits = 1;
        _selectedPort!.config = config;
        try {
          _serialPortReader = SerialPortReader(_selectedPort!, timeout: 20);
          _incomingDataStream = _serialPortReader!.stream;

          // .asyncMap((data) {
          //   return String.fromCharCodes(data);
          // });
          _incomingDataStream!.listen((data) {
            String ascii = "";
            String binary = "";
            String decimal = "";
            String hex = "";
            for (var element in data as Uint8List) {
              ascii += String.fromCharCode(element);
              binary += element.toRadixString(2) + " ";
              decimal += element.toRadixString(10) + " ";
              hex += element.toRadixString(16).toUpperCase() + " ";
            }
            ascii_list.add(ascii);
            binary_list.add(binary);
            decimal_list.add(decimal);
            hex_list.add(hex);
            // print(ascii_list);
            // print(binary_list);
            // print(decimal_list);
            // print(hex_list);
            // String str = String.fromCharCodes(data);
            // serialData.add(str);
            notifyListeners();
          });
          notifyListeners();
        } on SerialPortError catch (err, _) {
          // print(SerialPort.lastError);
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
    _selectedPort = value;
    notifyListeners();
  }

  void selectedBaudRateChanged(value) {
    _selectedBaudrate = value;
    notifyListeners();
  }

  void selectedDataBitsChanged(value) {
    _selectedDataBits = value;
    notifyListeners();
  }

  void selectedStopBitsChanged(value) {
    _selectedStopBits = value;
    notifyListeners();
  }

  void selectedParityChanged(value) {
    _selectedParity = value;
    notifyListeners();
  }

  SerialPort? get port => _selectedPort;
  String? get selectedBaudRate => _selectedBaudrate;
  String? get selectedDataBits => _selectedDataBits;
  String? get selectedStopBits => _selectedStopBits;
  String? get selectedParity => _selectedParity;

  bool get autoScroll => _autoScroll;
  set autoScroll(bool value) {
    _autoScroll = value;
    notifyListeners();
  }
}
