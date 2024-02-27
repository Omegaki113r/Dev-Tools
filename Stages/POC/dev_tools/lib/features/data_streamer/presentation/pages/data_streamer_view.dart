/*
 * Project: Xtronic Dev Tools
 * File Name: data_streamer_view.dart
 * File Created: Thursday, 25th January 2024 10:42:21 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:31:43 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'package:dev_tools/core/constants/app_colors.dart';
import 'package:dev_tools/core/constants/app_constants.dart';
import 'package:dev_tools/core/constants/app_strings.dart';
import 'package:dev_tools/core/services/data_streamer/serial_service.dart';
import 'package:dev_tools/core/widgets/soft_tab.dart';
import 'package:dev_tools/features/data_streamer/presentation/provider/mqtt_streamer_provider.dart';
import 'package:dev_tools/features/data_streamer/presentation/provider/serial_streamer_provider.dart';
import 'package:dev_tools/features/data_streamer/presentation/provider/websocket_provider.dart';
import 'package:dev_tools/features/data_streamer/presentation/widgets/mqtt_tabview.dart';
import 'package:dev_tools/features/data_streamer/presentation/widgets/serial_tabview.dart';
import 'package:dev_tools/features/data_streamer/presentation/widgets/websocket_tabview.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class DataStreamerView extends StatefulWidget {
  const DataStreamerView({super.key});

  @override
  State<DataStreamerView> createState() => _DataStreamerViewState();
}

class _DataStreamerViewState extends State<DataStreamerView> {
  StreamerType currentStreamer = StreamerType.serial;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 500),
      length: 3,
      child: Column(
        children: [
          TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: color2,
            indicatorSize: TabBarIndicatorSize.tab,
            onTap: (value) {
              setState(() {
                switch (value) {
                  case 0:
                    currentStreamer = StreamerType.serial;
                    break;
                  case 1:
                    currentStreamer = StreamerType.websocket;
                    break;
                  case 2:
                    currentStreamer = StreamerType.mqtt;
                    break;
                }
              });
            },
            tabs: [
              SoftTab(
                lblSerial,
                thisTab: StreamerType.serial,
                currentTab: currentStreamer,
              ),
              SoftTab(
                lblWebSocket,
                thisTab: StreamerType.websocket,
                currentTab: currentStreamer,
              ),
              SoftTab(
                lblMQTT,
                thisTab: StreamerType.mqtt,
                currentTab: currentStreamer,
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                ChangeNotifierProvider(
                  create: (context) => SerialStreamerProvider(
                    GetIt.instance.get<SerialService>(),
                  ),
                  child: const SerialTabView(),
                ),
                ChangeNotifierProvider(
                  create: (context) => WebSocketStreamerProvider(),
                  child: const WebSocketTabView(),
                ),
                ChangeNotifierProvider(
                  create: (context) => MQTTStreamerProvider(),
                  child: const MQTTTabView(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
