import 'package:cfit/util/routes.dart';
import 'package:flutter/widgets.dart';

class LoginNavigation {
  final void Function() toRegister;
  final void Function() toHome;
  final void Function() toRecoverPassword;

  LoginNavigation({
    required this.toRegister,
    required this.toHome,
    required this.toRecoverPassword,
  });

  factory LoginNavigation.fromMaterialNavigation(
    NavigatorState navigator,
  ) {
    return LoginNavigation(
      toRegister: () => navigator.pushNamed(Routes.register),
      toHome: () => navigator.pushReplacementNamed(Routes.home),
      toRecoverPassword: () => navigator.pushNamed(Routes.recover_password),
    );
  }
}
