import 'package:dev_tools/const/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:gap/gap.dart';

class SoftTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function onChanged;
  final double? width;
  final double? height;
  final String? label;
  final bool? readOnly;
  const SoftTextField(
      {super.key,
      this.height,
      this.width,
      this.label,
      this.readOnly,
      required this.controller,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        color: color6,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            offset: Offset(-10, -10),
            blurRadius: 20,
            spreadRadius: -10,
            color: Color(0xFF312C5E),
            inset: true,
          ),
          BoxShadow(
            offset: Offset(10, 10),
            blurRadius: 20,
            spreadRadius: -10,
            color: Color(0xFF050227),
            inset: true,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label ?? ""),
            Gap(10),
            TextField(
              decoration: const InputDecoration(
                isDense: true,
                // contentPadding: EdgeInsets.all(0),
              ),
              readOnly: readOnly ?? false,
              controller: controller,
              onChanged: (value) => onChanged(value),
            ),
          ],
        ),
      ),
    );
  }
}
