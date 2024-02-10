import 'package:flutter/material.dart';

class SoftCard extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final double? cornerRadius;
  const SoftCard(
      {super.key,
      required this.child,
      this.height,
      this.width,
      this.cornerRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          Color(0xFF2C2754),
          Color(0xFF0F0B2F),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: cornerRadius != null
            ? BorderRadius.all(Radius.circular(cornerRadius!))
            : null,
        boxShadow: const [
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
      child: child,
    );
  }
}
