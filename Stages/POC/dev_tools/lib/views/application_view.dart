import 'package:dev_tools/const/app_colors.dart';
import 'package:dev_tools/providers/app_provider.dart';
import 'package:dev_tools/views/type_converter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ApplicationView extends StatelessWidget {
  const ApplicationView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: color6MaterialColor,
          accentColor: color6MaterialColor,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: color6MaterialColor,
          accentColor: color6MaterialColor,
        ),
      ),
      home: Scaffold(
        body: Row(
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Type\nConverter",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Type\nConverter",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Type\nConverter",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )),
            Expanded(
              flex: 10,
              child: switch (context.watch<AppProvider>().selectedView) {
                SelectedView.TYPE_CONVERTER => TypeConverterView(),
                SelectedView.STREAMER => Container(
                    color: Colors.red,
                  )
              },
            )
          ],
        ),
      ),
    );
  }
}
