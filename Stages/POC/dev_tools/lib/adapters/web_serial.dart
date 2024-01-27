
import 'package:dev_tools/interfaces/Iserial.dart';
import 'package:serial/serial.dart';

SerialInterface getSerialAdapter() => WebSerialInterface();

class WebSerialInterface implements SerialInterface {
  WebSerialInterface() {
    print("WebSerial Initialized");
  }

  @override
  List<String> getAvailablePorts() {
    List<String> serialNameList = [];
    return serialNameList;
  }

  @override
  SerialPort? getPort(String portName) {
    SerialPort? port;
    return port;
  }
  
  @override
  bool close() {
    return false;
  }
  
  @override
  SerialPort? getSelectedPort() {
    return null;
  }
}
