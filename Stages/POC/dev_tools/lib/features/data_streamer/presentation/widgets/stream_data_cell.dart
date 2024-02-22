import 'package:flutter/material.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            ascii ?? "",
            style: const TextStyle(
              color: Colors.red,
            ),
            textAlign: TextAlign.end,
          ),
          Text(
            hex ?? "",
            style: const TextStyle(
              color: Colors.amber,
            ),
          ),
          Text(
            decimal ?? "",
            style: const TextStyle(
              color: Colors.blue,
            ),
          ),
          Text(
            binary ?? "",
            style: const TextStyle(
              color: Colors.yellow,
            ),
          ),
        ],
      ),
    );
  }
}
