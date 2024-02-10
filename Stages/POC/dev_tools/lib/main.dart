import 'dart:io';
import 'package:dev_tools/core/const/app_strings.dart';
import 'package:dev_tools/core/provider/app_provider.dart';
import 'package:dev_tools/config/routes/app_route.dart';
import 'package:dev_tools/features/data_streamer/presentation/provider/streamer_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'package:dev_tools/config/themes/app_themes.dart';
import 'package:dev_tools/features/bitwise_calculator/presentation/provider/type_converter_provider.dart';

void main() async {
  if (kIsWeb) {
  } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(1480, 720),
      minimumSize: Size(1480, 720),
      // titleBarStyle: TitleBarStyle.hidden,
      title: appName,
      backgroundColor: Colors.transparent,
      // center: true,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      // await windowManager.setIcon("xtronic_home_logo.jpg");
      // await windowManager.setResizable(false);
      // await windowManager.setAsFrameless();
      // await windowManager.maximize();
      // await windowManager.focus();
    });
  }
  runApp(const ProviderWidget());
}

class ProviderWidget extends StatelessWidget {
  const ProviderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(create: (context) => AppProvider()),
        ChangeNotifierProvider<TypeConverterProvider>(
            create: (context) => TypeConverterProvider()),
        ChangeNotifierProvider<StreamerProvider>(
            create: (context) => StreamerProvider())
      ],
      child: const AppWidget(),
    );
  }
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRoute.router,
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
