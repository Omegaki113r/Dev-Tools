import 'package:dev_tools/interfaces/Iserial.dart';
import 'package:serial/serial.dart';

SerialInterface getSerialAdapter() => WebSerialInterface();

class WebSerialInterface implements SerialInterface {
  // Map<String, SerialPort?> portList = {};
  // SerialPort? _selectedPort;
  WebSerialInterface() {
    print("WebSerial Initialized");
    // window.navigator.serial.requestPort().then((port) => _selectedPort = port);
    // _selectedPort!.readable.reader.read().asStream()
  }

  @override
  List<String> getAvailablePorts() {
    List<String> serialNameList = [];
    return serialNameList;
  }

  @override
  dynamic getPort(String portName) {
    // window.navigator.serial.requestPort().then((port) => _selectedPort = port);
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
