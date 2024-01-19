import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SoftDropDown extends StatefulWidget {
  final double? width;
  final double? height;
  final List<dynamic> itemList;
  final Function? onChanged;
  const SoftDropDown(
      {super.key,
      this.height,
      this.width,
      required this.itemList,
      this.onChanged});

  @override
  State<SoftDropDown> createState() => _SoftDropDownState();
}

class _SoftDropDownState extends State<SoftDropDown> {
  dynamic _selectedValue;
  @override
  Widget build(BuildContext context) {
    if (widget.itemList.isNotEmpty) {
      _selectedValue = widget.itemList.first;
      if (widget.onChanged != null && _selectedValue != null) {
        widget.onChanged!(_selectedValue);
      }
    }

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: const BoxDecoration(
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
        child: widget.itemList.isEmpty
            ? Center(child: Text("No COM Port"))
            : DropdownButton<String>(
                value: _selectedValue,
                isExpanded: true,
                underline: Container(),
                items: List.generate(
                  widget.itemList.length,
                  (index) => DropdownMenuItem(
                    value: widget.itemList[index],
                    child: Text(widget.itemList[index]),
                  ),
                ),
                onChanged: ((value) {
                  setState(
                    () {
                      if (value != null) {
                        _selectedValue = value;
                      }
                    },
                  );
                  if (widget.onChanged != null && value != null) {
                    widget.onChanged!(value);
                  }
                }),
              ),
      ),
    );
  }
}
