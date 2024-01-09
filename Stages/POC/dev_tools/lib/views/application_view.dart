import 'dart:ui';

import 'package:dev_tools/const/app_colors.dart';
import 'package:dev_tools/const/app_themes.dart';
import 'package:dev_tools/providers/app_provider.dart';
import 'package:dev_tools/views/type_converter_view.dart';
import 'package:dev_tools/widgets/side_bar_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ApplicationView extends StatelessWidget {
  const ApplicationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          SizedBox(
            width: 200,
            child: Stack(
              children: [
                ClipRRect(
                  // borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 20,
                      sigmaY: 20,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: color6.withOpacity(0.9),
                        // borderRadius: BorderRadius.all(
                        //   Radius.circular(20),
                        // ),
                        // border: Border.all(
                        //   width: 1.5,
                        //   color: Colors.white.withOpacity(0.2),
                        // ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 200,
                    child: Column(
                      children: [
                        SidebarButton(
                          "Type Converter",
                          50,
                          ButtonType.CONCAVE,
                          onPressed: () {
                            print("pressed");
                          },
                        ),
                        SidebarButton(
                          "Type\nConverter",
                          50,
                          ButtonType.FLAT,
                          onPressed: () {
                            print("pressed");
                          },
                        ),
                        SidebarButton(
                          "Type\nConverter",
                          50,
                          ButtonType.FLAT,
                          onPressed: () {
                            print("pressed");
                          },
                        ),
                        SidebarButton(
                          "Type\nConverter",
                          50,
                          ButtonType.FLAT,
                          onPressed: () {
                            print("pressed");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: switch (context.watch<AppProvider>().selectedView) {
              SelectedView.TYPE_CONVERTER => const TypeConverterView(),
              SelectedView.STREAMER => Container()
            },
          )
        ],
      ),
    );
  }
}
