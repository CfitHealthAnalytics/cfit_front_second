import 'package:cfit/domain/models/address.dart';
import 'package:flutter/widgets.dart';

class SelectLocalizationNavigation {
  final void Function([Address address]) onBack;

  SelectLocalizationNavigation({
    required this.onBack,
  });

  factory SelectLocalizationNavigation.fromMaterialNavigation(
    NavigatorState navigator,
  ) {
    return SelectLocalizationNavigation(
      onBack: navigator.pop,
    );
  }
}
