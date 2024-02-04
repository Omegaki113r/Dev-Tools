import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SoftCheckbox extends StatelessWidget {
  final String label;
  final Function(bool?)? onChanged;
  final bool value;
  const SoftCheckbox(this.label,
      {super.key, required this.onChanged, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: GestureDetector(
        onTap: () => onChanged!(!value),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: value
              ? Row(
                  key: ValueKey(1),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Checkbox(
                    //   value: value,
                    //   onChanged: onChanged,
                    // ),
                    Icon(Icons.check_sharp),
                    const Gap(10),
                    Text(label),
                  ],
                )
              : Row(
                  key: ValueKey(2),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Checkbox(
                    //   value: value,
                    //   onChanged: onChanged,
                    // ),
                    Icon(Icons.check_box_outline_blank),
                    const Gap(10),
                    Text(label),
                  ],
                ),
        ),
      ),
    );
  }
}
