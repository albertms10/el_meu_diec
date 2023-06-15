import 'package:flutter/cupertino.dart';

Future<T?> pushTranslucentRoutePageBuilder<T>({
  required BuildContext context,
  required RoutePageBuilder pageBuilder,
}) {
  return Navigator.of(context).push<T>(
    PageRouteBuilder<T>(
      opaque: false,
      fullscreenDialog: true,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return CupertinoFullscreenDialogTransition(
          primaryRouteAnimation:
              Tween<double>(begin: 0, end: 1).animate(animation),
          secondaryRouteAnimation:
              Tween<double>(begin: 0, end: 1).animate(secondaryAnimation),
          linearTransition: false,
          child: child,
        );
      },
      pageBuilder: pageBuilder,
    ),
  );
}
