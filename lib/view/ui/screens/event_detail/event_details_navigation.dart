import 'package:cfit/util/routes.dart';
import 'package:flutter/widgets.dart';

class EventDetailsNavigation {
  final void Function() toHome;
  final void Function() onBack;
  final void Function() toLogin;

  EventDetailsNavigation({
    required this.onBack,
    required this.toHome,
    required this.toLogin,
  });

  factory EventDetailsNavigation.fromMaterialNavigation(
    NavigatorState navigator,
  ) {
    return EventDetailsNavigation(
      onBack: navigator.pop,
      toHome: () => navigator.pushReplacementNamed(Routes.home),
      toLogin: () => navigator.pushReplacementNamed(Routes.login),
    );
  }
}
