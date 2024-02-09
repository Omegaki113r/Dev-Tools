import 'package:dev_tools/const/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SoftCheckbox extends StatelessWidget {
  final String label;
  final TextStyle? labelStyle;
  final double? iconSize;
  final Function(bool?) onChanged;
  final bool value;
  const SoftCheckbox(
    this.label, {
    super.key,
    required this.onChanged,
    required this.value,
    this.labelStyle,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      // child: GestureDetector(
      //   onTap: () => onChanged!(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            splashRadius: 0,
            side: BorderSide(color: Color(0xFFFFFFFF).withOpacity(0.08)),
          ),
          const Gap(10),
          Text(
            label,
            style: labelStyle,
          ),
        ],
      ),
      // ),
    );
  }
}
