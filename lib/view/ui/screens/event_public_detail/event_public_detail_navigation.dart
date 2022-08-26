import 'package:cfit/util/routes.dart';
import 'package:flutter/widgets.dart';

class EventPublicDetailsNavigation {
  final void Function() toHome;
  final void Function() onBack;
  final void Function() toLogin;

  EventPublicDetailsNavigation({
    required this.onBack,
    required this.toHome,
    required this.toLogin,
  });

  factory EventPublicDetailsNavigation.fromMaterialNavigation(
    NavigatorState navigator,
  ) {
    return EventPublicDetailsNavigation(
      onBack: () => navigator.pop(true),
      toHome: () => navigator.pushReplacementNamed(Routes.home),
      toLogin: () => navigator.pushReplacementNamed(Routes.login),
    );
  }
}
