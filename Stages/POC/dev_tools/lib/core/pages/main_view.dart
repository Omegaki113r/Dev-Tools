import 'package:dev_tools/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  const MainView({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(-10, 0),
              blurRadius: 20,
              color: Colors.black,
            ),
          ],
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 255, 255, 0.8),
              Color.fromRGBO(255, 255, 255, 0),
            ],
            stops: [
              0.1,
              0.3,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: color6,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
