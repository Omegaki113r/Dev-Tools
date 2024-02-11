import 'package:dev_tools/features/data_streamer/presentation/provider/serial_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:serial/serial.dart';

SerialInterface getSerialInterface() => WebSerialInterface();

class WebSerialInterface implements SerialInterface {
  SerialPort? _selectedPort;
  ReadableStream? _serialPortReader;

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
  String get name => throw UnimplementedError("name getter not implemented");

  @override
  bool get isOpen => throw UnimplementedError("isOpen getter not implemented");

  @override
  get port => _selectedPort;

  @override
  get reader => _serialPortReader;

  @override
  List<String> get portList => [];
}
