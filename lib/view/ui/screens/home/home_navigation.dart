import 'package:cfit/util/routes.dart';
import 'package:flutter/widgets.dart';

class HomeNavigation {
  final void Function() toLogin;
  final void Function() toHome;

  HomeNavigation({
    required this.toLogin,
    required this.toHome,
  });

  factory HomeNavigation.fromMaterialNavigation(
    NavigatorState navigator,
  ) {
    return HomeNavigation(
      toLogin: () => navigator.pushReplacementNamed(Routes.login),
      toHome: () => navigator.pushReplacementNamed(Routes.home),
    );
  }
}
