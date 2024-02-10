import 'package:dev_tools/core/services/data_streamer/serial_service.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeServices() async {
  serviceLocator.registerSingleton<SerialService>(SerialService());
}
