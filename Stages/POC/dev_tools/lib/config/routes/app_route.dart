import 'package:dev_tools/core/constants/app_constants.dart';
import 'package:dev_tools/core/pages/application_view.dart';
import 'package:dev_tools/features/bitwise_calculator/presentation/pages/bitwise_calculator_view.dart';
import 'package:dev_tools/features/data_streamer/presentation/pages/data_streamer_view.dart';
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
    initialLocation: bitwiseCalculatorRoute,
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
        ],
        builder: (context, state, child) {
          return ApplicationView(child);
        },
      ),
    ],
  );

  static GoRouter get router => _router;
}
