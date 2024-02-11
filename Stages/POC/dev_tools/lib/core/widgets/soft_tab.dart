import 'package:dev_tools/core/constants/app_colors.dart';
import 'package:dev_tools/core/widgets/soft_text.dart';
import 'package:flutter/material.dart';

class SoftTab<T> extends StatelessWidget {
  final String text;
  final T currentTab;
  final T thisTab;
  const SoftTab(this.text,
      {super.key, required this.thisTab, required this.currentTab});

  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 75,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: currentTab == thisTab
            ? SoftText.titleFlat(
                text,
                key: UniqueKey(),
                width: double.infinity,
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: color2),
              )
            : SoftText.title(
                text,
                key: const ValueKey(2),
                width: double.infinity,
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: color1),
              ),
      ),
    );
  }
}
