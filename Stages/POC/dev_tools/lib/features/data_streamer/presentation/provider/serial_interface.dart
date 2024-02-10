import 'package:dev_tools/features/data_streamer/presentation/provider/serial_stub.dart'
    if (dart.library.io) 'package:dev_tools/features/data_streamer/presentation/provider/desktop_serial.dart'
    if (dart.library.html) 'package:dev_tools/features/data_streamer/presentation/provider/web_serial.dart';

abstract class SerialInterface {
  factory SerialInterface() => getSerialInterface();
  dynamic getPort(String portName);
  dynamic getSelectedPort();
  List<String> getAvailablePorts();
  bool close();
  String get name;
  bool get isOpen;
}
