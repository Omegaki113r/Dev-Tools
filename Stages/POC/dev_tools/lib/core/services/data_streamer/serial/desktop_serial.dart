  @override
  void setBaudrate(int newBaudrate) {
    if (_selectedPort != null) {
      SerialPortConfig config = _selectedPort!.config;
      config.baudRate = newBaudrate;
      _selectedPort!.config = config;
    }
  }

  @override
  void setStopbits(int newStopbits) {
    if (_selectedPort != null) {
      SerialPortConfig config = _selectedPort!.config;
      config.stopBits = newStopbits;
      _selectedPort!.config = config;
    }
  }

  @override
  void setDatabits(int newBits) {
    if (_selectedPort != null) {
      SerialPortConfig config = _selectedPort!.config;
      config.bits = newBits;
      _selectedPort!.config = config;
    }
  }

  @override
  void setParity(int newParity) {
    if (_selectedPort != null) {
      SerialPortConfig config = _selectedPort!.config;
      config.parity = newParity;
      _selectedPort!.config = config;
    }
  }
