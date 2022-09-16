import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/domain/models/events_public.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/util/routes.dart';
import 'package:cfit/view/ui/screens/event_city_admin/event_city_admin_arguments.dart';
import 'package:cfit/view/ui/screens/event_city_detail/event_city_detail_arguments.dart';
import 'package:cfit/view/ui/screens/event_public_detail/event_public_detail_arguments.dart';
import 'package:cfit/view/ui/screens/my_event/my_event_arguments.dart';
import 'package:cfit/view/ui/screens/select_localization/select_localization_arguments.dart';
import 'package:cfit/view/ui/screens/select_localization/select_localization_response.dart';
import 'package:flutter/widgets.dart';

class HomeNavigation {
  final void Function() toLogin;
  final void Function() toHome;
  final void Function(
    EventCity event,
    User user, {
    required bool alreadyConfirmed,
  }) toEventCityDetail;
  final void Function(
    EventPublic event,
    User user, {
    required bool alreadyConfirmed,
  }) toEventPublicDetail;
  final void Function(EventCity event) toEventCityAdmin;
  final void Function(EventPublic event, User user) toEventPublicAdmin;
  final Future<SelectLocalizationResponse?> Function({
    required bool toCreateEvent,
    required User user,
  }) toMap;

  HomeNavigation({
    required this.toLogin,
    required this.toHome,
    required this.toEventCityDetail,
    required this.toEventPublicDetail,
    required this.toEventCityAdmin,
    required this.toEventPublicAdmin,
    required this.toMap,
  });

  factory HomeNavigation.fromMaterialNavigation(
    NavigatorState navigator,
  ) {
    return HomeNavigation(
      toLogin: () => navigator.pushReplacementNamed(Routes.login),
      toHome: () => navigator.pushReplacementNamed(Routes.home),
      toEventCityDetail: (
        EventCity event,
        User user, {
        required bool alreadyConfirmed,
      }) =>
          navigator.pushNamed(
        Routes.event_city_details,
        arguments: EventCityDetailsArguments.fromMap({
          'event_city': event.toMap(),
          'user': user.toMap(),
          'already_confirmed': alreadyConfirmed,
        }).toJson(),
      ),
      toEventPublicDetail: (
        EventPublic event,
        User user, {
        required bool alreadyConfirmed,
      }) =>
          navigator.pushNamed(
        Routes.event_public_details,
        arguments: EventPublicDetailsArguments.fromMap({
          'event_public': event.toMap(),
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
      toEventPublicAdmin: (EventPublic event, User user) => navigator.pushNamed(
        Routes.event_public_admin,
        arguments: MyEventArguments(eventPublic: event, user: user).toJson(),
      ),
      toMap: ({
        required bool toCreateEvent,
        required User user,
      }) async {
        final response = await navigator.pushNamed<SelectLocalizationResponse?>(
          Routes.map,
          arguments: SelectLocalizationArguments(
            toCreateEvent: toCreateEvent,
            user: user,
          ).toJson(),
        );
        return response;
      },
    );
  }
}
