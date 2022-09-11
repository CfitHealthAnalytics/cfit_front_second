import 'package:cfit/domain/models/address.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/util/bottom_sheet.dart';
import 'package:cfit/view/ui/screens/create_public_event/create_public_event_modal.dart';
import 'package:flutter/widgets.dart';

class SelectLocalizationNavigation {
  final void Function([Address address]) onBack;
  final void Function([Address address]) goToCreateEvent;

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
      goToCreateEvent: ([Address? address]) => presentBottomSheet(
        context: navigator.context,
        modal: CreatePublicEventModal(
          user: user,
          onCreate: (created) {},
          address: address,
        ),
      ),
    );
  }
}
