import 'dart:io';

import 'package:dev_tools/const/app_colors.dart';
import 'package:dev_tools/const/app_constants.dart';
import 'package:dev_tools/providers/data_streamer_provider.dart';
import 'package:dev_tools/utils/app_route.dart';
import 'package:dev_tools/views/type_converter_view.dart';
import 'package:dev_tools/views/sidebar_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'package:dev_tools/const/app_themes.dart';
import 'package:dev_tools/providers/app_provider.dart';
import 'package:dev_tools/providers/type_converter_provider.dart';
import 'package:dev_tools/views/application_view.dart';

void main() async {
  if (kIsWeb) {
  } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(1280, 720),
      minimumSize: Size(1280, 720),
      // titleBarStyle: TitleBarStyle.hidden,
      title: "Xtronic DevTools",
      backgroundColor: Colors.transparent,
      // center: true,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      // await windowManager.setResizable(false);
      // await windowManager.setAsFrameless();
      // await windowManager.maximize();
      await windowManager.focus();
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
        ChangeNotifierProvider<DataStreamerProvider>(
            create: (context) => DataStreamerProvider())
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
