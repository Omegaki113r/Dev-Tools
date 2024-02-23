import 'package:dev_tools/core/constants/app_colors.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:gap/gap.dart';

class StreamDataCell extends StatelessWidget {
  final String? ascii;
  final String? binary;
  final String? decimal;
  final String? hex;
  const StreamDataCell(
      {super.key, this.ascii, this.binary, this.decimal, this.hex});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            color6,
            color6,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.all(Radius.circular(10)),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(4),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: color6,
                borderRadius: BorderRadius.all(Radius.circular(8)),
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
              child: Text(
                ascii ?? "",
                style: const TextStyle(
                  color: Colors.red,
                ),
                textAlign: TextAlign.end,
              ),
            ),
            const Gap(4),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: color6,
                borderRadius: BorderRadius.all(Radius.circular(8)),
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
              child: Text(
                hex ?? "",
                style: const TextStyle(
                  color: Colors.amber,
                ),
                textAlign: TextAlign.end,
              ),
            ),
            const Gap(4),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: color6,
                borderRadius: BorderRadius.all(Radius.circular(8)),
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
              child: Text(
                decimal ?? "",
                style: const TextStyle(
                  color: Colors.blue,
                ),
                textAlign: TextAlign.end,
              ),
            ),
            const Gap(4),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: color6,
                borderRadius: BorderRadius.all(Radius.circular(8)),
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
              child: Text(
                binary ?? "",
                style: const TextStyle(
                  color: Colors.yellow,
                ),
                textAlign: TextAlign.end,
              ),
            ),
            const Gap(4),
          ],
        ),
      ),
    );
  }
}
