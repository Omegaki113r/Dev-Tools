import 'package:dev_tools/features/data_streamer/presentation/provider/serial_interface.dart';

const Map<String, int> baudList = {
  "300": 300,
  "600": 600,
  "1200": 1200,
  "2400": 2400,
  "4800": 4800,
  "9600": 9600,
  "14400": 14400,
  "19200": 19200,
  "28800": 28800,
  "38400": 38400,
  "56000": 56000,
  "57600": 57600,
  "115200": 115200,
  "128000": 128000,
  "256000": 256000,
};
const Map<String, int> dataBits = {
  "5": 5,
  "6": 6,
  "7": 7,
  "8": 8,
};
const Map<String, double> stopBits = {
  "1": 1,
  "1.5": 1.5,
  "2": 2,
};
const List<String> parity = [
  "None",
  "Odd",
  "Even",
  "Mark",
  "Space",
];

class SerialService {
  final SerialInterface _serialInterface = SerialInterface();

  get reader => _serialInterface.reader;

  get port => _serialInterface.port;

  get portList => _serialInterface.portList;

  set port(port) {
    _serialInterface.port = port;
  }

  void dispose() {
    _serialInterface.dispose();
  }

  bool fetchPortList() {
    return _serialInterface.fetchPortList();
  }

  bool connect() {
    return _serialInterface.connect();
  }

  bool disconnect() {
    return _serialInterface.disconnect();
  }

  void setBaudrate(int newBaudrate) {
    _serialInterface.setBaudrate(newBaudrate);
  }

  void setDatabits(int newBaudrate) {
    _serialInterface.setDatabits(newBaudrate);
  }

  void setStopbits(int newBaudrate) {
    _serialInterface.setStopbits(newBaudrate);
  }

  void setParity(int newBaudrate) {
    _serialInterface.setParity(newBaudrate);
  }
}
