import 'package:cfit/util/routes.dart';
import 'package:flutter/widgets.dart';

class MyMeasureNavigation {
  final void Function() toHome;
  final void Function() onBack;
  final void Function() toLogin;

  MyMeasureNavigation({
    required this.onBack,
    required this.toHome,
    required this.toLogin,
  });

  factory MyMeasureNavigation.fromMaterialNavigation(
    NavigatorState navigator,
  ) {
    return MyMeasureNavigation(
      onBack: navigator.pop,
      toHome: () => navigator.pushReplacementNamed(Routes.home),
      toLogin: () => navigator.pushReplacementNamed(Routes.login),
    );
  }
}
