/*
 * Project: Xtronic Dev Tools
 * File Name: service_locator.dart
 * File Created: Saturday, 10th February 2024 11:13:40 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:32:09 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'package:dev_tools/core/services/data_streamer/serial_service.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeServices() async {
  serviceLocator.registerSingleton<SerialService>(SerialService());
}
