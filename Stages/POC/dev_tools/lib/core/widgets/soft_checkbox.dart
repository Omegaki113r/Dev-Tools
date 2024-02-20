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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          splashRadius: 0,
          side: BorderSide(color: const Color(0xFFFFFFFF).withOpacity(0.08)),
        ),
        const Gap(10),
        Text(
          label,
          style: labelStyle,
        ),
      ],
    );
  }
}
