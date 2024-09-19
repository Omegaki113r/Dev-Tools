/*
 * Project: Xtronic Dev Tools
 * File Name: app_route.dart
 * File Created: Thursday, 11th January 2024 11:33:22 am
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:29:14 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'package:dev_tools/core/constants/app_constants.dart';
import 'package:dev_tools/core/pages/application_view.dart';
import 'package:dev_tools/features/bitwise_calculator/presentation/pages/bitwise_calculator_view.dart';
import 'package:dev_tools/features/data_streamer/presentation/pages/data_streamer_view.dart';
import 'package:dev_tools/features/json_configurator/presentation/pages/json_configurator_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      );
    },
  );
}

class AppRoute {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();
  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    // initialLocation: dataStreamerRoute,
    initialLocation: jSONConfiguratorRoute,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        routes: [
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: bitwiseCalculatorRoute,
            builder: (context, state) {
              return const TypeConverterView();
            },
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: const TypeConverterView());
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: dataStreamerRoute,
            builder: (context, state) {
              return const DataStreamerView();
            },
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: const DataStreamerView());
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: jSONConfiguratorRoute,
            builder: (context, state) {
              return const JSONConfiguratorView();
            },
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: const JSONConfiguratorView());
            },
          ),
        ],
        builder: (context, state, child) {
          return ApplicationView(child);
        },
      ),
    ],
  );

  static GoRouter get router => _router;
}
