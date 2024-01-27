

import 'package:dev_tools/adapters/serial_stub.dart'
  if(dart.library.html) 'package:dev_tools/adapters/web_serial.dart'
  if(dart.library.io) 'package:dev_tools/adapters/desktop_serial.dart';

abstract class SerialInterface {
  factory SerialInterface() => getSerialInterface();
  dynamic getPort(String portName);
  dynamic getSelectedPort();
  List<String> getAvailablePorts();
  bool close();
}