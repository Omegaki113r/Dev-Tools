import 'package:dev_tools/core/services/data_streamer/serial/serial_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:serial/serial.dart';

SerialInterface getSerialInterface() => WebSerialInterface();

class WebSerialInterface implements SerialInterface {
  WebSerialInterface() {
    if (kDebugMode) {
      print("WebSerial Initialized");
    }
  }

  @override
  void dispose() {
    throw UnimplementedError("dispose not implemented");
  }

  @override
  bool fetchPortList() {
    bool listChanged = false;
    return listChanged;
  }

  @override
  bool connect() {
    throw UnimplementedError("connect not implemented");
  }

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
  get port => throw UnimplementedError("port getter not implemented");

  @override
  set port(port) {
    throw UnimplementedError("set port not implemented");
  }

  @override
  Stream? get reader => throw UnimplementedError("get reader not implemented");

  @override
  List<String> get portNameList =>
      throw UnimplementedError("get portNameList not implemented");

  @override
  Map<String, SerialPort?> get portList =>
      throw UnimplementedError("get portList not implemented");

  @override
  void setBaudrate(int newBaudrate) =>
      throw UnimplementedError("setBaudrate not implemented");

  @override
  void setDatabits(int newBits) =>
      throw UnimplementedError("setBits not implemented");

  @override
  void setParity(int newParity) =>
      throw UnimplementedError("setParity not implemented");

  @override
  void setStopbits(int newStopbits) =>
      throw UnimplementedError("setStopbits not implemented");
}
