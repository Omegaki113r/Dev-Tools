import 'package:dev_tools/core/services/data_streamer/serial/serial_stub.dart'
    if (dart.library.io) 'package:dev_tools/core/services/data_streamer/serial/desktop_serial.dart'
    if (dart.library.html) 'package:dev_tools/core/services/data_streamer/serial/web_serial.dart';

abstract class SerialInterface {
  factory SerialInterface() => getSerialInterface();
  void dispose();
  bool fetchPortList();
  bool connect();
  bool disconnect();
  void setBaudrate(String newBaudrate);
  void setDatabits(String newDatabits);
  void setStopbits(String newStopbits);
  void setParity(String newParity);
  String get name;
  bool get isOpen;
  Stream? get reader;
  get port;
  set port(dynamic port);
  get portNameList;
  get portList;
  List<String> get baudrateList;
  List<String> get dataBitList;
  List<String> get stopBitList;
  List<String> get parityList;
}
