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

import 'dart:html';
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
  ReadableStreamReader? _serialPortReader;
  bool _isOpen = false;

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
  Future<bool> connect(
      String selectedBaudrate,
      String selectedDataBits,
      String selectedParity,
      String selectedStopBits,
      bool ctsFlowControl) async {
    if (_selectedPort != null) {
      await _selectedPort?.close();
      _selectedPort = null;
    }
    SerialPort port = await window.navigator.serial.requestPort();
    _selectedPort = port;
    await _selectedPort?.open(
        baudRate: _baudrate,
        dataBits: _dataBits,
        stopBits: _stopBits,
        parity: _parity);
    _serialPortReader = _selectedPort?.readable.reader;
    _isOpen = true;
    // final reader = port.readable.reader;
    // while (true) {
    //   final result = await reader.read();
    //   print(result?.value ?? "");
    // }
    return true;
  }

  @override
  bool get isConnected => _isOpen;

  @override
  bool disconnect() {
    _closeStreams();
    _selectedPort?.close();
    _isOpen = false;
    _selectedPort = null;
    return true;
  }

  void _closeStreams() {
    if (_serialPortReader != null) {
      _serialPortReader?.releaseLock();
    }
  }

  @override
  String get name => throw UnimplementedError("name getter not implemented");

  @override
  bool get isOpen => _isOpen;

  @override
  get port => _selectedPort;

  @override
  set port(port) {
    throw UnimplementedError("set port not implemented");
  }

  // @override
  // Stream? get reader => _selectedPort!.readable.reader.read().asStream();

  @override
  Stream? get reader => timedCounter();

  Stream<Uint8List> timedCounter() async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 400));
      try {
        final result = await _serialPortReader?.read();
        yield result!.value;
      } catch (e) {
        return;
      }
    }
  }

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
