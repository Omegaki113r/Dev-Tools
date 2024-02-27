/*
 * Project: Xtronic Dev Tools
 * File Name: serial_streamer_provider.dart
 * File Created: Sunday, 28th January 2024 7:09:06 am
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 8:57:04 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'dart:async';
import 'package:dev_tools/core/services/data_streamer/serial_service.dart';
import 'package:dev_tools/features/data_streamer/domain/entities/stream_data_entitiy.dart';
import 'package:dev_tools/features/data_streamer/domain/usecases/serial_convert_usecase.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SerialStreamerProvider<T> with ChangeNotifier {
  List<String> serialData = [];

  String? _selectedBaudrate = "115200";
  String? _selectedDataBits = "8";
  String? _selectedStopBits = "1";
  String? _selectedParity = "None";

  int _rxData = 0;
  int _txData = 0;
  List<StreamDataEntity> charDataList = [];
  ScrollController scrollController = ScrollController();
  DragSelectGridViewController controller = DragSelectGridViewController();

  bool _autoScroll = true;
  bool _ctsFlowControl = false;
  bool _ascii = true;
  bool _binary = false;
  bool _decimal = false;
  bool _hex = false;

  late Timer _serialSearchTimer;

  final SerialService _serialService;
  final SerialConvert _convertUsecase = SerialConvert();

  SerialStreamerProvider(this._serialService) {
    if (!kIsWeb) {
      _serialSearchTimer = Timer.periodic(
        const Duration(seconds: 1),
        _serialSearchTimerCallback,
      );
    }
    controller.addListener(listener);
  }

  void listener() {
    if (kDebugMode) {
      print(controller.value);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _serialSearchTimer.cancel();
    _serialService.dispose();
    controller.removeListener(listener);
    super.dispose();
  }

  void _serialSearchTimerCallback(Timer timer) {
    if (_serialService.fetchPortList()) {
      notifyListeners();
    }
  }

  void serialPortConnect() {
    if (_serialService.connect()) {
      _serialService.reader?.listen((data) {
        _serialDataReceivedHandler(data);
      });
      notifyListeners();
    }
  }

  void _serialDataReceivedHandler(Uint8List incomingBytes) {
    _rxData += incomingBytes.length;
    _convertUsecase.convertCharacter(incomingBytes).listen((event) {
      charDataList.add(event);

      notifyListeners();
    });
  }

  void serialPortDisconnect() {
    if (_serialService.disconnect()) {
      notifyListeners();
    }
  }

  void selectedSerialPortChanged(value) {
    _serialService.port = value;
    notifyListeners();
  }

  void selectedBaudRateChanged(value) {
    _selectedBaudrate = value;
    _serialService.setBaudrate(value);
    notifyListeners();
  }

  void selectedDataBitsChanged(value) {
    _selectedDataBits = value;
    _serialService.setDatabits(value);
    notifyListeners();
  }

  void selectedStopBitsChanged(value) {
    _selectedStopBits = value;
    _serialService.setStopbits(value);
    notifyListeners();
  }

  void selectedParityChanged(value) {
    _selectedParity = value;
    _serialService.setParity(value);
    notifyListeners();
  }

  void resetRXCounter() {
    _rxData = 0;
    notifyListeners();
  }

  void resetTXCounter() {
    _txData = 0;
    notifyListeners();
  }

  T get port => _serialService.port;
  Map<String, dynamic> get portList => _serialService.portList;
  String? get selectedBaudRate => _selectedBaudrate;
  String? get selectedDataBits => _selectedDataBits;
  String? get selectedStopBits => _selectedStopBits;
  String? get selectedParity => _selectedParity;

  bool get autoScroll => _autoScroll;

  set autoScroll(bool value) {
    _autoScroll = value;
    notifyListeners();
  }

  bool get ctsFlowControl => _ctsFlowControl;
  set ctsFlowControl(value) {
    _ctsFlowControl = value;
    notifyListeners();
  }

  bool get ascii => _ascii;
  set ascii(bool value) {
    _ascii = value;
    notifyListeners();
  }

  bool get binary => _binary;
  set binary(bool value) {
    _binary = value;
    notifyListeners();
  }

  bool get decimal => _decimal;

  set decimal(bool value) {
    _decimal = value;
    notifyListeners();
  }

  bool get hex => _hex;
  set hex(bool value) {
    _hex = value;
    notifyListeners();
  }

  List<String> get baudrateList => _serialService.baudrateList;
  List<String> get dataBitList => _serialService.dataBitList;
  List<String> get stopBitList => _serialService.stopBitList;
  List<String> get parityList => _serialService.parityList;
  int get rxData => _rxData;
  int get txData => _txData;
}
