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
      body: Row(
        children: [
          SizedBox(
            width: 200,
            child: Column(
              children: [
                SidebarButton(
                  "Type\nConverter",
                  onPressed: () {
                    print("pressed");
                  },
                ),
                SidebarButton(
                  "Type\nConverter",
                  onPressed: () {
                    print("pressed");
                  },
                ),
                SidebarButton(
                  "Type\nConverter",
                  onPressed: () {
                    print("pressed");
                  },
                ),
                SidebarButton(
                  "Type\nConverter",
                  onPressed: () {
                    print("pressed");
                  },
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
