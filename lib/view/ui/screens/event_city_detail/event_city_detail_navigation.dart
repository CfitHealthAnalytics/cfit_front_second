import 'package:cfit/util/routes.dart';
import 'package:flutter/widgets.dart';

class EventCityDetailsNavigation {
  final void Function() toHome;
  final void Function() onBack;
  final void Function() toLogin;

  EventCityDetailsNavigation({
    required this.onBack,
    required this.toHome,
    required this.toLogin,
  });

  factory EventCityDetailsNavigation.fromMaterialNavigation(
    NavigatorState navigator,
  ) {
    return EventCityDetailsNavigation(
      onBack: () => navigator.pop(true),
      toHome: () => navigator.pushReplacementNamed(Routes.home),
      toLogin: () => navigator.pushReplacementNamed(Routes.login),
    );
  }
}
