import 'package:dev_tools/core/constants/app_strings.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;

class MQTTTabView extends StatelessWidget {
  const MQTTTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(lblMQTT),
    );
  }
}
