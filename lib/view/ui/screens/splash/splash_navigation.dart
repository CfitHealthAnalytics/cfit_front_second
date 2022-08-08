import 'package:cfit/util/routes.dart';
import 'package:flutter/widgets.dart';

class SplashNavigation {
  final void Function() toLogin;
  final void Function() toHome;

  SplashNavigation({
    required this.toLogin,
    required this.toHome,
  });

  factory SplashNavigation.fromMaterialNavigation(
    NavigatorState navigator,
  ) {
    return SplashNavigation(
      toLogin: () => navigator.pushReplacementNamed(Routes.login),
      toHome: () => navigator.pushReplacementNamed(Routes.home),
    );
  }
}
