import 'package:dev_tools/features/data_streamer/presentation/provider/serial_interface.dart';
import 'package:flutter/foundation.dart';

SerialInterface getSerialInterface() => DesktopSerialInterface();

class DesktopSerialInterface implements SerialInterface {
  // Map<String, SerialPort?> portList = {};
  // SerialPort? _selectedPort;
  // SerialPortReader? _serialPortReader;
  // Stream? _incomingDataStream;
  // String serialData = "";

  DesktopSerialInterface() {
    if (kDebugMode) {
      print("DesktopSerial Initialized");
    }
  }

  @override
  List<String> getAvailablePorts() {
    List<String> serialNameList = [];
    return serialNameList;
  }

  @override
  dynamic getPort(String portName) {
    return null;
  }

  @override
  dynamic getSelectedPort() {
    return null;
  }

  @override
  bool close() {
    return false;
  }

  @override
  String get name => throw UnimplementedError("name getter not implemented");

  @override
  bool get isOpen => throw UnimplementedError("isOpen getter not implemented");
}
