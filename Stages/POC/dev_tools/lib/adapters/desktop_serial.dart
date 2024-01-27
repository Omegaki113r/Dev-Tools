import 'package:dev_tools/interfaces/Iserial.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

SerialInterface getSerialInterface() => DesktopSerialInterface();

class DesktopSerialInterface implements SerialInterface {
  Map<String, SerialPort?> portList = {};
  SerialPort? _selectedPort;
  DesktopSerialInterface() {
    print("DesktopSerial Initialized");
  }

  @override
  List<String> getAvailablePorts() {
    return SerialPort.availablePorts;
  }

  @override
  SerialPort? getPort(String portName) {
    return SerialPort(portName);
  }

  @override
  SerialPort? getSelectedPort() {
    return _selectedPort;
  }

  @override
  bool close() {
    return _selectedPort == null ? false : _selectedPort!.close();
  }

  String? get name => _selectedPort?.name;
  bool get isOpen => _selectedPort?.isOpen ?? false;
}
