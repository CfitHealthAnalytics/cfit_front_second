import 'package:cfit/util/routes.dart';
import 'package:flutter/widgets.dart';

class RegisterNavigation {
  final void Function() toHome;
  final void Function() onBack;

  RegisterNavigation({
    required this.onBack,
    required this.toHome,
  });

  factory RegisterNavigation.fromMaterialNavigation(
    NavigatorState navigator,
  ) {
    return RegisterNavigation(
      onBack: navigator.pop,
      toHome: () => navigator.pushNamed(Routes.home),
    );
  }
}
