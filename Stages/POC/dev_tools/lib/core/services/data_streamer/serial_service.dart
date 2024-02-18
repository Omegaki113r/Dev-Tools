import 'package:dev_tools/core/services/data_streamer/serial/serial_interface.dart';

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

  void setBaudrate(String newBaudrate) {
    _serialInterface.setBaudrate(newBaudrate);
  }

  void setDatabits(String newDatabits) {
    _serialInterface.setDatabits(newDatabits);
  }

  void setStopbits(String newStopbits) {
    _serialInterface.setStopbits(newStopbits);
  }

  void setParity(String newPairty) {
    _serialInterface.setParity(newPairty);
  }

  List<String> get baudrateList => _serialInterface.baudrateList;
  List<String> get dataBitList => _serialInterface.dataBitList;
  List<String> get stopBitList => _serialInterface.stopBitList;
  List<String> get parityList => _serialInterface.parityList;
}
