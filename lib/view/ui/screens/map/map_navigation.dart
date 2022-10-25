import 'package:flutter/widgets.dart';

class MapNavigation {
  final void Function() onBack;

  MapNavigation({
    required this.onBack,
  });

  factory MapNavigation.fromMaterialNavigation(
    NavigatorState navigator,
  ) {
    return MapNavigation(
      onBack: navigator.pop,
    );
  }
}
