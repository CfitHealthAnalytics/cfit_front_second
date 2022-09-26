import 'package:cfit/util/routes.dart';
import 'package:flutter/widgets.dart';

class RecoverPasswordNavigation {
  final void Function() toRegister;
  final void Function() toHome;
  final void Function() goBack;

  RecoverPasswordNavigation({
    required this.toRegister,
    required this.toHome,
    required this.goBack,
  });

  factory RecoverPasswordNavigation.fromMaterialNavigation(
    NavigatorState navigator,
  ) {
    return RecoverPasswordNavigation(
      goBack: navigator.pop,
      toRegister: () => navigator.pushNamed(Routes.register),
      toHome: () => navigator.pushReplacementNamed(Routes.home),
    );
  }
}
