import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/util/routes.dart';
import 'package:cfit/view/ui/screens/event_city_admin/event_city_admin_arguments.dart';
import 'package:cfit/view/ui/screens/event_detail/event_details_arguments.dart';
import 'package:flutter/widgets.dart';

class HomeNavigation {
  final void Function() toLogin;
  final void Function() toHome;
  final void Function(
    EventCity event,
    User user, {
    required bool alreadyConfirmed,
  }) toEventDetail;
  final void Function(EventCity event) toEventCityAdmin;

  HomeNavigation({
    required this.toLogin,
    required this.toHome,
    required this.toEventDetail,
    required this.toEventCityAdmin,
  });

  factory HomeNavigation.fromMaterialNavigation(
    NavigatorState navigator,
  ) {
    return HomeNavigation(
      toLogin: () => navigator.pushReplacementNamed(Routes.login),
      toHome: () => navigator.pushReplacementNamed(Routes.home),
      toEventDetail: (
        EventCity event,
        User user, {
        required bool alreadyConfirmed,
      }) =>
          navigator.pushNamed(
        Routes.event_details,
        arguments: EventDetailsArguments.fromMap({
          'event_city': event.toMap(),
          'user': user.toMap(),
          'already_confirmed': alreadyConfirmed,
        }).toJson(),
      ),
      toEventCityAdmin: (EventCity event) => navigator.pushNamed(
        Routes.event_city_admin,
        arguments: EventCityAdminArguments.fromMap({
          'event_city': event.toMap(),
        }).toJson(),
      ),
    );
  }
}
