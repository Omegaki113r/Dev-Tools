import 'package:dev_tools/const/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SidebarButton extends StatefulWidget {
  String label;
  Function onPressed;
  SidebarButton(this.label, {super.key, required this.onPressed});

  @override
  State<SidebarButton> createState() => _SidebarButtonState();
}

class _SidebarButtonState extends State<SidebarButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
        bottom: 20.0,
        left: 20.0,
        right: 30.0,
      ),
      child: TextButton(
        onPressed: () {
          widget.onPressed();
        },
        // style: Theme.of(context).textButtonTheme.style,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: color6,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                offset: Offset(-5, -5),
                blurRadius: 10,
                color: Color(0xFF312C5E),
              ),
              BoxShadow(
                offset: Offset(5, 5),
                blurRadius: 10,
                color: Color(0xFF050227),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ),
    );
  }
}
