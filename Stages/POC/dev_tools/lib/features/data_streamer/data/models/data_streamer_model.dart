import 'package:serial/serial.dart';

class DataStreamerModel {
  COMPortModel? comPortModel;

  DataStreamerModel.comPortModel(String comPort) {
    comPortModel = COMPortModel(comPort);
  }
}

class COMPortModel {
  String portName;
  SerialPort? port;
  COMPortModel(this.portName);
}
