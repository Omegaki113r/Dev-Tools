import 'dart:io';

import 'package:dev_tools/const/app_colors.dart';
import 'package:dev_tools/models/type_converter_model.dart';
import 'package:dev_tools/providers/app_provider.dart';
import 'package:dev_tools/providers/type_converter_provider.dart';
import 'package:dev_tools/views/application_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:desktop_window/desktop_window.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (Platform.isWindows) {
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    size: Size(1200, 1000),
    minimumSize: Size(1200, 1000),
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    // await windowManager.maximize();
    await windowManager.focus();
  });

  // Size size = await DesktopWindow.getWindowSize();
  // print(size);
  // await DesktopWindow.setWindowSize(Size(1200, 1000));
  // await DesktopWindow.setMinWindowSize(Size(5200, 1000));
  // await DesktopWindow.setMaxWindowSize(Size(1200, 1000));

  // await DesktopWindow.resetMaxWindowSize();
  // await DesktopWindow.toggleFullScreen();
  // await DesktopWindow.toggleFullScreen();
  // bool isFullScreen = await DesktopWindow.getFullScreen();
  // await DesktopWindow.setFullScreen(true);
  // }
  runApp(const ProviderWidget());
}

class ProviderWidget extends StatelessWidget {
  const ProviderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(
          create: (context) => AppProvider(),
        ),
        ChangeNotifierProvider<TypeConverterProvider>(
          create: (context) => TypeConverterProvider(),
        ),
      ],
      child: const ApplicationView(),
    );
  }
}
