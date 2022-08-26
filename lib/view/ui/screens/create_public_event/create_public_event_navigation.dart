import 'package:cfit/domain/models/address.dart';
import 'package:cfit/util/routes.dart';
import 'package:cfit/view/ui/screens/select_localization/select_localization_arguments.dart';
import 'package:flutter/widgets.dart';

class CreatePublicEventNavigation {
  final Future<Address?> Function() toMap;
  final void Function() back;

  CreatePublicEventNavigation({
    required this.toMap,
    required this.back,
  });

  factory CreatePublicEventNavigation.fromMaterialNavigation(
    NavigatorState navigator,
  ) {
    return CreatePublicEventNavigation(
      toMap: () async {
        final address = await navigator.pushNamed<Address?>(
          Routes.map,
          arguments: SelectLocalizationArguments(
            toCreateEvent: false,
          ).toJson(),
        );
        return address;
      },
      back: navigator.pop,
    );
  }
}
