import 'package:dev_tools/core/constants/app_constants.dart';
import 'package:dev_tools/core/constants/app_strings.dart';
import 'package:dev_tools/core/widgets/soft_button.dart';
import 'package:dev_tools/core/widgets/soft_divider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SidebarView extends StatefulWidget {
  final double width;
  final Color backgroundColor;
  const SidebarView(this.width, this.backgroundColor, {super.key});

  @override
  State<SidebarView> createState() => _SidebarState();
}

class _SidebarState extends State<SidebarView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.backgroundColor,
            ),
          ),
          ListView(
            children: [
              SoftButton(
                lblBitwiseCalculator,
                ButtonType.flat,
                height: 60,
                padding: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 20.0,
                  left: 20.0,
                  right: 30.0,
                ),
                onPressed: () {
                  GoRouter.of(context).go(bitwiseCalculatorRoute);
                },
              ),
              const SoftDivider(),
              SoftButton(
                lblDataStreamer,
                ButtonType.flat,
                height: 60,
                padding: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 20.0,
                  left: 20.0,
                  right: 30.0,
                ),
                onPressed: () {
                  GoRouter.of(context).go(dataStreamerRoute);
                },
              ),
              const SoftDivider(),
            ],
          ),
        ],
      ),
    );
  }
}
