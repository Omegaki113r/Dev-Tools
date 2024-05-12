/*
 * Project: Xtronic Dev Tools
 * File Name: web_serial.dart
 * File Created: Thursday, 25th January 2024 6:42:28 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:29:59 pm
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
import 'package:serial/serial.dart';

Map<String, int> baudList = {
  "300": 300,
  "600": 600,
  "1200": 1200,
  "2400": 2400,
  "4800": 4800,
  "9600": 9600,
  "14400": 14400,
  "19200": 19200,
  "28800": 28800,
  "38400": 38400,
  "56000": 56000,
  "57600": 57600,
  "115200": 115200,
  "128000": 128000,
  "256000": 256000,
};

const Map<String, Parity> parity = {
  "None": Parity.none,
  "Odd": Parity.odd,
  "Even": Parity.even,
};

const Map<String, DataBits> dataBits = {
  "7": DataBits.seven,
  "8": DataBits.eight,
};
const Map<String, StopBits> stopBits = {
  "1": StopBits.one,
  "2": StopBits.two,
};

SerialInterface getSerialInterface() => WebSerialInterface();

class WebSerialInterface implements SerialInterface {
  final Map<String, SerialPort?> _portList = {};
  SerialPort? _selectedPort;

  int _baudrate = 115200;
  Parity _parity = Parity.none;
  DataBits _dataBits = DataBits.eight;
  StopBits _stopBits = StopBits.one;

  WebSerialInterface() {
    if (kDebugMode) {
      print("WebSerial Initialized");
    }
  }

  @override
  void dispose() {
    if (_selectedPort != null) {
      _selectedPort!.close();
    }
  }

  @override
  bool fetchPortList() {
    bool listChanged = false;
    return listChanged;
  }

  @override
  bool connect(String selectedBaudrate, String selectedDataBits,
      String selectedParity, String selectedStopBits, bool ctsFlowControl) {
    // SerialPort port = await window.navigator.serial.requestPort();
    // if (port != null) {
    //   _selectedPort = port;
    //   _selectedPort?.open(
    //       baudRate: _baudrate,
    //       dataBits: _dataBits,
    //       stopBits: _stopBits,
    //       parity: _parity);
    //   return true;
    // }
    // return false;
    return false;
  }

  @override
  bool get isConnected =>
      throw UnimplementedError("isConnected not implemented");

  @override
  bool disconnect() {
    _closeStreams();
    throw UnimplementedError("disconnect not implemented");
  }

  void _closeStreams() =>
      throw UnimplementedError("_closeStreams not implemented");

  @override
  String get name => throw UnimplementedError("name getter not implemented");

  @override
  bool get isOpen => throw UnimplementedError("isOpen getter not implemented");

  @override
  get port => _selectedPort;

  @override
  set port(port) {
    throw UnimplementedError("set port not implemented");
  }

  @override
  Stream? get reader => _selectedPort!.readable.reader.read().asStream().cast();

  @override
  write(Uint8List bytesToWrite) =>
      throw UnimplementedError("write not implemented");

  @override
  ctsFlowControl(bool ctsFlowControl) =>
      throw UnimplementedError("CTS Flow control not implemented");

  @override
  List<String> get portNameList =>
      throw UnimplementedError("get portNameList not implemented");

  @override
  Map<String, SerialPort?> get portList => _portList;

  @override
  void setBaudrate(String newBaudrate) {
    _baudrate = baudList[newBaudrate]!;
    if (_selectedPort != null) {
      _selectedPort?.close();
      _selectedPort?.open(
          baudRate: _baudrate,
          dataBits: _dataBits,
          stopBits: _stopBits,
          parity: _parity);
    }
  }

  @override
  void setDatabits(String newBits) {
    _dataBits = dataBits[newBits]!;
    if (_selectedPort != null) {
      _selectedPort?.close();
      _selectedPort?.open(
          baudRate: _baudrate,
          dataBits: _dataBits,
          stopBits: _stopBits,
          parity: _parity);
    }
  }

  @override
  void setParity(String newParity) {
    _parity = parity[newParity]!;
    if (_selectedPort != null) {
      _selectedPort?.close();
      _selectedPort?.open(
          baudRate: _baudrate,
          dataBits: _dataBits,
          stopBits: _stopBits,
          parity: _parity);
    }
  }

  @override
  void setStopbits(String newStopbits) {
    _stopBits = stopBits[newStopbits]!;
    if (_selectedPort != null) {
      _selectedPort?.close();
      _selectedPort?.open(
          baudRate: _baudrate,
          dataBits: _dataBits,
          stopBits: _stopBits,
          parity: _parity);
    }
  }

  @override
  List<String> get baudrateList => baudList.keys.toList();
  @override
  List<String> get dataBitList => dataBits.keys.toList();
  @override
  List<String> get stopBitList => stopBits.keys.toList();
  @override
  List<String> get parityList => parity.keys.toList();
}
