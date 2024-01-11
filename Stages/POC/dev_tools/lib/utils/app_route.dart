import 'package:dev_tools/const/app_constants.dart';
import 'package:dev_tools/views/application_view.dart';
import 'package:dev_tools/views/type_converter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();
  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: TYPE_CONVERTER,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        routes: [
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: TYPE_CONVERTER,
            builder: (context, state) {
              return TypeConverterView();
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: DATA_STREAMER,
            builder: (context, state) {
              return Container(
                color: Colors.red,
              );
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
