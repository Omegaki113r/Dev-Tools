import 'dart:io';

import 'package:dev_tools/const/app_colors.dart';
import 'package:dev_tools/const/app_themes.dart';
import 'package:dev_tools/models/type_converter_model.dart';
import 'package:dev_tools/providers/app_provider.dart';
import 'package:dev_tools/providers/type_converter_provider.dart';
import 'package:dev_tools/views/application_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:desktop_window/desktop_window.dart';

void main() async {
  if (kIsWeb) {
  } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1920, 1080),
      minimumSize: Size(1280, 720),
      // titleBarStyle: TitleBarStyle.hidden,
      title: "Xtronic DevTools",
      // backgroundColor: Colors.transparent,
      // center: true,
    );
    // await windowManager.setResizable(false);
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();

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
          ChangeNotifierProvider<AppProvider>(
            create: (context) => AppProvider(),
          ),
          ChangeNotifierProvider<TypeConverterProvider>(
            create: (context) => TypeConverterProvider(),
          ),
        ],
        child: MaterialApp(
          themeMode: ThemeMode.system,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: const ApplicationView(),
        ));
  }
}
