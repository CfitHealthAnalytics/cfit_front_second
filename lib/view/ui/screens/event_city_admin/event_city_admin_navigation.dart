import 'package:cfit/util/routes.dart';
import 'package:flutter/widgets.dart';

class EventCityAdminNavigation {
  final void Function() toHome;
  final void Function() onBack;
  final void Function() toLogin;

  EventCityAdminNavigation({
    required this.onBack,
    required this.toHome,
    required this.toLogin,
  });

  factory EventCityAdminNavigation.fromMaterialNavigation(
    NavigatorState navigator,
  ) {
    return EventCityAdminNavigation(
      onBack: () => navigator.pop(true),
      toHome: () => navigator.pushReplacementNamed(Routes.home),
      toLogin: () => navigator.pushReplacementNamed(Routes.login),
    );
  }
}
