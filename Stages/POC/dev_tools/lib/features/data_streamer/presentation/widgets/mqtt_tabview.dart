/*
 * Project: Xtronic Dev Tools
 * File Name: mqtt_tabview.dart
 * File Created: Sunday, 11th February 2024 11:01:10 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:31:56 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

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
