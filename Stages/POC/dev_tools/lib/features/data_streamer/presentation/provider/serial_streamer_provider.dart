import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

const List<String> baudList = [
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
const List<String> dataBits = [
  "5",
  "6",
  "7",
  "8",
];
const List<String> stopBits = [
  "1",
  "1.5",
  "2",
];
const List<String> parity = [
  "None",
  "Odd",
  "Even",
  "Mark",
  "Space",
];

class SerialStreamerProvider with ChangeNotifier {
  SerialPortReader? _serialPortReader;
  Stream? _incomingDataStream;
  List<String> serialData = [];

  SerialPort? _selectedPort;
  String? _selectedBaudrate = "115200";
  String? _selectedDataBits = "8";
  String? _selectedStopBits = "1";
  String? _selectedParity = "None";
  Map<String, SerialPort?> portList = {};

  List<String> asciiList = [];
  List<String> hexList = [];
  List<String> decimalList = [];
  List<String> binaryList = [];
  List<String> dataList = [];
  ScrollController scrollController = ScrollController();

  bool _autoScroll = true;
  bool _ctsFlowControl = false;
  bool _ascii = true;
  bool _binary = false;
  bool _decimal = false;
  bool _hex = false;

  late Timer serialSearchTimer;

  SerialStreamerProvider() {
    serialSearchTimer =
        Timer.periodic(const Duration(seconds: 1), serialSearchTimerCallback);
  }

  @override
  void dispose() {
    serialSearchTimer.cancel();
    if (_selectedPort != null && _selectedPort!.isOpen) {
      _serialPortReader!.close();
      bool closeState = _selectedPort!.close();
      if (closeState) {
        notifyListeners();
      }
    }
    serialSearchTimer.cancel();
    super.dispose();
  }

  void serialSearchTimerCallback(Timer timer) {
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
              binary += "${element.toRadixString(2)} ";
              decimal += "${element.toRadixString(10)} ";
              var hex0 = element.toRadixString(16).toUpperCase();
              // hex += element.toRadixString(16).toUpperCase() + " ";
              hex += "${hex0.padLeft(2, "0")} ";
            }
            asciiList.add(ascii);
            binaryList.add(binary);
            decimalList.add(decimal);
            hexList.add(hex);

            dataList.clear();
            for (var i = 0; i < asciiList.length; i++) {
              if (_ascii) {
                dataList.add(asciiList[i]);
              }
              if (_binary) {
                // dataList.clear();
                dataList.add(binaryList[i]);
              }
              if (_decimal) {
                // dataList.clear();
                dataList.add(decimalList[i]);
              }
              if (_hex) {
                // dataList.clear();
                dataList.add(hexList[i]);
              }
            }

            // print(asciiList);
            // print(binaryList);
            // print(decimalList);
            // print(hexList);
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
        _selectedPort!.close();
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

  bool get ctsFlowControl => _ctsFlowControl;
  set ctsFlowControl(value) {
    _ctsFlowControl = value;
    notifyListeners();
  }

  bool get ascii => _ascii;
  set ascii(bool value) {
    _ascii = value;
    notifyListeners();
  }

  bool get binary => _binary;
  set binary(bool value) {
    _binary = value;
    notifyListeners();
  }

  bool get decimal => _decimal;
  set decimal(bool value) {
    _decimal = value;
    notifyListeners();
  }

  bool get hex => _hex;
  set hex(bool value) {
    _hex = value;
    notifyListeners();
  }
}
