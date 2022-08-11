import 'package:cfit/util/routes.dart';
import 'package:flutter/widgets.dart';

class MyDataNavigation {
  final void Function() toHome;
  final void Function() onBack;
  final void Function() toLogin;

  MyDataNavigation({
    required this.onBack,
    required this.toHome,
    required this.toLogin,
  });

  factory MyDataNavigation.fromMaterialNavigation(
    NavigatorState navigator,
  ) {
    return MyDataNavigation(
      onBack: navigator.pop,
      toHome: () => navigator.pushReplacementNamed(Routes.home),
      toLogin: () => navigator.pushReplacementNamed(Routes.login),
    );
  }
}
