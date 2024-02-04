import 'package:dev_tools/interfaces/Iserial.dart';

SerialInterface getSerialInterface() => DesktopSerialInterface();

class DesktopSerialInterface implements SerialInterface {
  // Map<String, SerialPort?> portList = {};
  // SerialPort? _selectedPort;
  // SerialPortReader? _serialPortReader;
  // Stream? _incomingDataStream;
  // String serialData = "";

  DesktopSerialInterface() {
    print("DesktopSerial Initialized");
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

  String get name => throw UnimplementedError("name getter not implemented");

  bool get isOpen => throw UnimplementedError("isOpen getter not implemented");
}
