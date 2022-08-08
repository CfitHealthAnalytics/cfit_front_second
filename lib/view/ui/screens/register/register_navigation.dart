import 'package:cfit/util/routes.dart';
import 'package:flutter/widgets.dart';

class RegisterNavigation {
  final void Function() toHome;
  final void Function() onBack;
  final void Function() toLogin;

  RegisterNavigation({
    required this.onBack,
    required this.toHome,
    required this.toLogin,
  });

  factory RegisterNavigation.fromMaterialNavigation(
    NavigatorState navigator,
  ) {
    return RegisterNavigation(
      onBack: navigator.pop,
      toHome: () => navigator.pushReplacementNamed(Routes.home),
      toLogin: () => navigator.pushReplacementNamed(Routes.login),
    );
  }
}
