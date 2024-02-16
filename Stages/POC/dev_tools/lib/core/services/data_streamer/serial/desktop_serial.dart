import 'package:dev_tools/core/services/data_streamer/serial/serial_interface.dart';
import 'package:dev_tools/core/services/data_streamer/serial_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

SerialInterface getSerialInterface() => DesktopSerialInterface();

class DesktopSerialInterface implements SerialInterface {
  final Map<String, SerialPort?> _portList = {};
  SerialPort? _selectedPort;
  SerialPortReader? _serialPortReader;

  DesktopSerialInterface() {
    if (kDebugMode) {
      print("DesktopSerial Initialized");
    }
  }

  @override
  void dispose() {
    if (_selectedPort != null && _selectedPort!.isOpen) {
      _serialPortReader!.close();
      _selectedPort!.close();
    }
  }

  @override
  bool fetchPortList() {
    bool listChanged = false;
    List<String> portNameList = SerialPort.availablePorts;
    if (portNameList.isEmpty && _portList.isNotEmpty) {
      _portList.clear();
      _selectedPort = null;
      listChanged = true;
    }
    for (String portName in portNameList) {
      if (!_portList.keys.contains(portName)) {
        _portList[portName] = SerialPort(portName);
        listChanged = true;
      }
      _selectedPort ??= _portList.values.first;
    }
    return listChanged;
  }

  @override
  bool connect() {
    bool openState = false;
    if (_selectedPort != null && !_selectedPort!.isOpen) {
      openState = _selectedPort!.openReadWrite();
      if (kDebugMode) {
        print("Open State: $openState");
      }
      if (openState) {
        SerialPortConfig config = _selectedPort!.config;
        config.baudRate = 115200;
        config.bits = 8;
        config.parity = 0;
        config.stopBits = 1;
        _selectedPort!.config = config;
        // try {
        if (_serialPortReader != null) {
          _serialPortReader?.close();
        }
        _serialPortReader = SerialPortReader(_selectedPort!, timeout: 10);
        // final _incomingDataStream = _serialPortReader!.stream;
        // _incomingDataStream!.listen((data) {
        //       String ascii = "";
        //       String binary = "";
        //       String decimal = "";
        //       String hex = "";
        // for (var element in data as Uint8List) {
        //   print(String.fromCharCode(element));
        // ascii += String.fromCharCode(element);
        //         binary += "${element.toRadixString(2)} ";
        //         decimal += "${element.toRadixString(10)} ";
        //         var hex0 = element.toRadixString(16).toUpperCase();
        //         // hex += element.toRadixString(16).toUpperCase() + " ";
        //         hex += "${hex0.padLeft(2, "0")} ";
        // }
        //       asciiList.add(ascii);
        //       binaryList.add(binary);
        //       decimalList.add(decimal);
        //       hexList.add(hex);

        //       dataList.clear();
        //       for (var i = 0; i < asciiList.length; i++) {
        //         if (_ascii) {
        //           dataList.add(asciiList[i]);
        //         }
        //         if (_binary) {
        //           // dataList.clear();
        //           dataList.add(binaryList[i]);
        //         }
        //         if (_decimal) {
        //           // dataList.clear();
        //           dataList.add(decimalList[i]);
        //         }
        //         if (_hex) {
        //           // dataList.clear();
        //           dataList.add(hexList[i]);
        //         }
        //       }

        //       // print(asciiList);
        //       // print(binaryList);
        //       // print(decimalList);
        //       // print(hexList);
        //       // String str = String.fromCharCodes(data);
        //       // serialData.add(str);
        //       notifyListeners();
        // });
        //     notifyListeners();
        // } on SerialPortError catch (err, _) {
        // print(SerialPort.lastError);
        // _selectedPort!.close();
        // }
      }
    } else {
      disconnect();
    }
    return openState;
  }

  @override
  bool disconnect() {
    bool closeState = false;
    if (_selectedPort != null && _selectedPort!.isOpen) {
      _closeStreams();
      closeState = _selectedPort!.close();
    }
    return closeState;
  }

  void _closeStreams() {
    if (_serialPortReader != null) {
      _serialPortReader?.close();
    }
  }

  @override
  String get name => _selectedPort?.name ?? "";

  @override
  bool get isOpen => _selectedPort?.isOpen ?? false;

  @override
  get port => _selectedPort;

  @override
  set port(port) {
    _selectedPort = port;
  }

  @override
  Stream? get reader => _serialPortReader?.stream;

  @override
  List<String> get portNameList => SerialPort.availablePorts;

  @override
  Map<String, SerialPort?> get portList => _portList;

  @override
  void setBaudrate(int newBaudrate) {
    if (_selectedPort != null) {
      SerialPortConfig config = _selectedPort!.config;
      config.baudRate = newBaudrate;
      _selectedPort!.config = config;
    }
  }

  @override
  void setStopbits(int newStopbits) {
    if (_selectedPort != null) {
      SerialPortConfig config = _selectedPort!.config;
      config.stopBits = newStopbits;
      _selectedPort!.config = config;
    }
  }

  @override
  void setDatabits(int newBits) {
    if (_selectedPort != null) {
      SerialPortConfig config = _selectedPort!.config;
      config.bits = newBits;
      _selectedPort!.config = config;
    }
  }

  @override
  void setParity(int newParity) {
    if (_selectedPort != null) {
      SerialPortConfig config = _selectedPort!.config;
      config.parity = newParity;
      _selectedPort!.config = config;
    }
  }
}
