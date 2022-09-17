import 'package:cfit/domain/models/events_public.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/util/bottom_sheet.dart';
import 'package:cfit/util/routes.dart';
import 'package:cfit/view/ui/screens/create_public_event/create_public_event_modal.dart';
import 'package:flutter/widgets.dart';

import 'widgets/widgets.dart';

class MyEventNavigation {
  final void Function() toHome;
  final void Function() onBack;
  final void Function() toLogin;
  final void Function(EventPublic, User, void Function(bool, [String?]))
      toEditEvent;
  final void Function({required VoidCallback onRetry}) presentError;

  MyEventNavigation({
    required this.onBack,
    required this.toHome,
    required this.toLogin,
    required this.toEditEvent,
    required this.presentError,
  });

  factory MyEventNavigation.fromMaterialNavigation(
    NavigatorState navigator,
  ) {
    return MyEventNavigation(
      onBack: () => navigator.pop(true),
      toHome: () => navigator.pushReplacementNamed(Routes.home),
      toLogin: () => navigator.pushReplacementNamed(Routes.login),
      toEditEvent: (
        EventPublic event,
        User user,
        onCreate,
      ) =>
          presentBottomSheet(
        context: navigator.context,
        modal: CreatePublicEventModal(
          user: user,
          onCreate: onCreate,
          event: event,
          isEdit: true,
        ),
      ),
      presentError: ({required VoidCallback onRetry}) => presentBottomSheet(
        context: navigator.context,
        modal: UpdateErrorModal(
          onPressed: onRetry,
        ),
      ),
    );
  }
}
