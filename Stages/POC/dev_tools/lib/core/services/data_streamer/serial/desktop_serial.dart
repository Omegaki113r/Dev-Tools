import 'package:dev_tools/core/services/data_streamer/serial/serial_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

Map<String, int> baudList = {
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

const Map<String, int> parity = {
  "None": SerialPortParity.none,
  "Odd": SerialPortParity.odd,
  "Even": SerialPortParity.even,
  "Mark": SerialPortParity.mark,
  "Space": SerialPortParity.space,
};

const Map<String, int> dataBits = {
  "5": 5,
  "6": 6,
  "7": 7,
  "8": 8,
};
const Map<String, int> stopBits = {
  "1": 1,
  "2": 2,
};

SerialInterface getSerialInterface() => DesktopSerialInterface();

class DesktopSerialInterface implements SerialInterface {
  final Map<String, SerialPort?> _portList = {};
  SerialPort? _selectedPort;
  SerialPortReader? _serialPortReader;

  DesktopSerialInterface() {
    if (kDebugMode) {
      print("DesktopSerial Initialized");
    }
  }

  @override
  void dispose() {
    if (_selectedPort != null && _selectedPort!.isOpen) {
      _serialPortReader!.close();
      _selectedPort!.close();
    }
  }

  @override
  bool fetchPortList() {
    bool listChanged = false;
    List<String> portNameList = SerialPort.availablePorts;
    if (portNameList.isEmpty && _portList.isNotEmpty) {
      _portList.clear();
      _selectedPort = null;
      listChanged = true;
    }
    for (String portName in portNameList) {
      if (!_portList.keys.contains(portName)) {
        _portList[portName] = SerialPort(portName);
        listChanged = true;
      }
      _selectedPort ??= _portList.values.first;
    }
    return listChanged;
  }

  @override
  bool connect() {
    bool openState = false;
    if (_selectedPort != null && !_selectedPort!.isOpen) {
      openState = _selectedPort!.openReadWrite();
      if (kDebugMode) {
        print("Open State: $openState");
      }
      if (openState) {
        SerialPortConfig config = _selectedPort!.config;
        config.baudRate = 115200;
        config.bits = 8;
        config.parity = 0;
        config.stopBits = 1;
        _selectedPort!.config = config;
        // try {
        if (_serialPortReader != null) {
          _serialPortReader?.close();
        }
        _serialPortReader = SerialPortReader(_selectedPort!, timeout: 10);
      }
    } else {
      disconnect();
    }
    return openState;
  }

  @override
  bool disconnect() {
    bool closeState = false;
    if (_selectedPort != null && _selectedPort!.isOpen) {
      _closeStreams();
      closeState = _selectedPort!.close();
    }
    return closeState;
  }

  void _closeStreams() {
    if (_serialPortReader != null) {
      _serialPortReader?.close();
    }
  }

  @override
  String get name => _selectedPort?.name ?? "";

  @override
  bool get isOpen => _selectedPort?.isOpen ?? false;

  @override
  get port => _selectedPort;

  @override
  set port(port) {
    _selectedPort = port;
  }

  @override
  Stream? get reader => _serialPortReader?.stream;

  @override
  List<String> get portNameList => SerialPort.availablePorts;

  @override
  Map<String, SerialPort?> get portList => _portList;

  @override
  void setBaudrate(String newBaudrate) {
    if (_selectedPort != null) {
      SerialPortConfig config = _selectedPort!.config;
      config.baudRate = baudList[newBaudrate]!;
      _selectedPort!.config = config;
    }
  }

  @override
  void setStopbits(String newStopbits) {
    if (_selectedPort != null) {
      SerialPortConfig config = _selectedPort!.config;
      config.stopBits = stopBits[newStopbits]!;
      _selectedPort!.config = config;
    }
  }

  @override
  void setDatabits(String newBits) {
    if (_selectedPort != null) {
      SerialPortConfig config = _selectedPort!.config;
      config.bits = dataBits[newBits]!;
      _selectedPort!.config = config;
    }
  }

  @override
  void setParity(String newParity) {
    if (_selectedPort != null) {
      SerialPortConfig config = _selectedPort!.config;
      config.parity = parity[newParity]!;
      _selectedPort!.config = config;
    }
  }

  @override
  List<String> get baudrateList => baudList.keys.toList();
  @override
  List<String> get dataBitList => dataBits.keys.toList();
  @override
  List<String> get stopBitList => stopBits.keys.toList();
  @override
  List<String> get parityList => parity.keys.toList();
}
