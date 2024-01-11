import 'dart:ui';

import 'package:dev_tools/const/app_colors.dart';
import 'package:dev_tools/const/app_themes.dart';
import 'package:dev_tools/providers/app_provider.dart';
import 'package:dev_tools/views/main_view.dart';
import 'package:dev_tools/views/type_converter_view.dart';
import 'package:dev_tools/widgets/sidebar_button.dart';
import 'package:dev_tools/views/sidebar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ApplicationView extends StatelessWidget {
  final Widget child;
  const ApplicationView(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SidebarView(
            250,
            color6.withOpacity(0.9),
          ),
          MainView(child: child)
        ],
      ),
    );
  }
}
