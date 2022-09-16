import 'package:cfit/domain/models/user.dart';
import 'package:cfit/util/routes.dart';
import 'package:cfit/view/ui/screens/select_localization/select_localization_arguments.dart';
import 'package:cfit/view/ui/screens/select_localization/select_localization_response.dart';
import 'package:flutter/widgets.dart';

class CreatePublicEventNavigation {
  final Future<SelectLocalizationResponse?> Function() toMap;
  final void Function() back;

  CreatePublicEventNavigation({
    required this.toMap,
    required this.back,
  });

  factory CreatePublicEventNavigation.fromMaterialNavigation(
    NavigatorState navigator,
      {required User user}
  ) {
    return CreatePublicEventNavigation(
      toMap: () async {
        final response = await navigator.pushNamed<SelectLocalizationResponse?>(
          Routes.map,
          arguments: SelectLocalizationArguments(
            toCreateEvent: false,
            user: user,
          ).toJson(),
        );
        return response;
      },
      back: navigator.pop,
    );
  }
}
