import 'package:dev_tools/core/const/app_colors.dart';
import 'package:dev_tools/core/pages/main_view.dart';
import 'package:dev_tools/core/pages/sidebar_view.dart';
import 'package:flutter/material.dart';

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
          MainView(
            child: child,
          ),
        ],
      ),
    );
  }
}
