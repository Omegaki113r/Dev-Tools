import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SoftDropDown extends StatefulWidget {
  final double? width;
  final double? height;
  const SoftDropDown({super.key, this.height, this.width});

  @override
  State<SoftDropDown> createState() => _SoftDropDownState();
}

class _SoftDropDownState extends State<SoftDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: const BoxDecoration(
        // color: color6,
        gradient: LinearGradient(colors: [
          Color(0xFF0F0B2F),
          Color(0xFF2C2754),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            offset: Offset(-10, -10),
            blurRadius: 20,
            color: Color(0xFF312C5E),
          ),
          BoxShadow(
            offset: Offset(10, 10),
            blurRadius: 20,
            color: Color(0xFF050227),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: DropdownButton<String>(
            value: "NO COM",
            isExpanded: true,
            underline: Container(),
            items: [
              DropdownMenuItem(
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "NO COM",
                    textAlign: TextAlign.end,
                  ),
                ),
                value: "NO COM",
              ),
              DropdownMenuItem(
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "1",
                    textAlign: TextAlign.end,
                  ),
                ),
                value: "1",
              ),
              DropdownMenuItem(
                child: Text("2"),
                value: "2",
              ),
              DropdownMenuItem(
                child: Text("3"),
                value: "3",
              ),
              DropdownMenuItem(
                child: Text("4"),
                value: "4",
              ),
            ],
            onChanged: ((value) {
              print(value);
            })),
      ),
    );
  }
}
