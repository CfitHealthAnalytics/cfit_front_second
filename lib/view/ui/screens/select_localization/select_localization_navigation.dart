import 'package:cfit/domain/models/user.dart';
import 'package:cfit/util/bottom_sheet.dart';
import 'package:cfit/view/ui/screens/create_public_event/create_public_event_modal.dart';
import 'package:flutter/widgets.dart';

import 'select_localization_response.dart';

class SelectLocalizationNavigation {
  final void Function([SelectLocalizationResponse response]) onBack;
  final void Function([SelectLocalizationResponse response]) goToCreateEvent;

  SelectLocalizationNavigation({
    required this.onBack,
    required this.goToCreateEvent,
  });

  factory SelectLocalizationNavigation.fromMaterialNavigation(
    NavigatorState navigator, {
    required User user,
  }) {
    return SelectLocalizationNavigation(
      onBack: navigator.pop,
      goToCreateEvent: ([SelectLocalizationResponse? response]) =>
          presentBottomSheet(
        context: navigator.context,
        modal: CreatePublicEventModal(
          user: user,
          onCreate: (created) {
            if (created) {
              navigator.pop(
                SelectLocalizationResponse(
                  createdEvent: true,
                ),
              );
            }
          },
          address: response?.address,
        ),
      ),
    );
  }
}
