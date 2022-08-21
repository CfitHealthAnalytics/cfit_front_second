import 'package:cfit/util/routes.dart';
import 'package:flutter/widgets.dart';

class MyEventNavigation {
  final void Function() toHome;
  final void Function() onBack;
  final void Function() toLogin;

  MyEventNavigation({
    required this.onBack,
    required this.toHome,
    required this.toLogin,
  });

  factory MyEventNavigation.fromMaterialNavigation(
    NavigatorState navigator,
  ) {
    return MyEventNavigation(
      onBack: () => navigator.pop(true),
      toHome: () => navigator.pushReplacementNamed(Routes.home),
      toLogin: () => navigator.pushReplacementNamed(Routes.login),
    );
  }
}
