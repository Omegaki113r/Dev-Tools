import 'package:dev_tools/const/app_constants.dart';
import 'package:dev_tools/widgets/sidebar_button.dart';
import 'package:dev_tools/widgets/soft_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SidebarView extends StatefulWidget {
  double width;
  Color backgroundColor;
  SidebarView(this.width, this.backgroundColor, {super.key});

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
          Column(
            children: [
              SidebarButton(
                "Type Converter",
                50,
                ButtonType.FLAT,
                onPressed: () {
                  GoRouter.of(context).go(TYPE_CONVERTER);
                },
              ),
              Divider(),
              SidebarButton(
                "Data Streamer",
                50,
                ButtonType.FLAT,
                onPressed: () {
                  GoRouter.of(context).go(DATA_STREAMER);
                },
              ),
              Divider(),
              SoftButton(
                "hey",
                ButtonType.FLAT,
                height: 60,
                padding: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 20.0,
                  left: 20.0,
                  right: 30.0,
                ),
                onPressed: () {
                  print("Hey");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
