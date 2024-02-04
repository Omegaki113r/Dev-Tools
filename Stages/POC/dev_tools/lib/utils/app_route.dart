import 'package:dev_tools/const/app_constants.dart';
import 'package:dev_tools/views/application_view.dart';
import 'package:dev_tools/views/data_streamer_view.dart';
import 'package:dev_tools/views/type_converter_view.dart';
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
    transitionDuration: Duration(milliseconds: 300),
    reverseTransitionDuration: Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // return SlideTransition(
      //   position: Tween<Offset>(
      //     begin: const Offset(1, 0),
      //     end: Offset.zero,
      //   ).animate(animation),
      //   child: child,
      // );
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
    initialLocation: DATA_STREAMER,
    // initialLocation: TYPE_CONVERTER,
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
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition(
                  context: context, state: state, child: TypeConverterView());
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: DATA_STREAMER,
            builder: (context, state) {
              return DataStreamerView();
            },
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition(
                  context: context, state: state, child: DataStreamerView());
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
