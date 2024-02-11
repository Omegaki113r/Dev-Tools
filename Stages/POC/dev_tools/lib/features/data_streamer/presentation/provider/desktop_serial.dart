import 'package:dev_tools/features/data_streamer/presentation/provider/serial_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

SerialInterface getSerialInterface() => DesktopSerialInterface();

class DesktopSerialInterface implements SerialInterface {
  SerialPort? _selectedPort;
  SerialPortReader? _serialPortReader;

  DesktopSerialInterface() {
    if (kDebugMode) {
      print("DesktopSerial Initialized");
    }
  }

  @override
  void dispose() {
    throw UnimplementedError("dispose not implemented");
  }

  @override
  String get name => throw UnimplementedError("name getter not implemented");

  @override
  bool get isOpen => throw UnimplementedError("isOpen getter not implemented");

  @override
  get port => _selectedPort;

  @override
  get reader => _serialPortReader;

  @override
  List<String> get portList => SerialPort.availablePorts;
}
