import 'package:dev_tools/core/constants/app_strings.dart';
import 'package:dev_tools/core/provider/app_provider.dart';
import 'package:dev_tools/config/routes/app_route.dart';
import 'package:dev_tools/features/bitwise_calculator/domain/usecases/bitwise_convert_usecase.dart';
import 'package:dev_tools/features/bitwise_calculator/domain/usecases/bitwise_evaluate_usecase.dart';
import 'package:dev_tools/features/data_streamer/presentation/provider/streamer_provider.dart';
import 'package:dev_tools/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:dev_tools/config/themes/app_themes.dart';
import 'package:dev_tools/features/bitwise_calculator/presentation/provider/bitwise_calculator_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeServices();

  if (kIsWeb) {
  } else {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1280, 720),
      minimumSize: Size(1280, 720),
      title: appName,
      backgroundColor: Colors.transparent,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
    });
  }
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(
          create: (context) => AppProvider(),
        ),
        ChangeNotifierProvider<BitwiseCalculatorProvider>(
          create: (context) =>
              BitwiseCalculatorProvider(BitwiseConvert(), BitwiseEvaluate()),
        ),
        ChangeNotifierProvider<StreamerProvider>(
          create: (context) => StreamerProvider(),
        )
      ],
      child: MaterialApp.router(
        routerConfig: AppRoute.router,
        themeMode: ThemeMode.system,
        theme: lightTheme,
        darkTheme: darkTheme,
      ),
    );
  }
}
