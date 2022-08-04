import 'package:cfit/util/routes.dart';
import 'package:flutter/widgets.dart';

class LoginNavigation {
  final void Function() toRegister;
  final void Function() toHome;

  LoginNavigation({
    required this.toRegister,
    required this.toHome,
  });

  factory LoginNavigation.fromMaterialNavigation(
    NavigatorState navigator,
  ) {
    return LoginNavigation(
      toRegister: () => navigator.pushNamed(Routes.register),
      toHome: () => navigator.pushNamed(Routes.home),
    );
  }
}
