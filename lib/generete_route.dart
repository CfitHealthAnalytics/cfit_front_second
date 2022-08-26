import 'package:cfit/domain/models/address.dart';
import 'package:cfit/util/routes.dart';
import 'package:cfit/view/ui/screens/event_city_admin/event_city_admin_arguments.dart';
import 'package:cfit/view/ui/screens/event_city_admin/event_city_admin_route.dart';
import 'package:cfit/view/ui/screens/event_city_detail/event_city_detail_arguments.dart';
import 'package:cfit/view/ui/screens/event_city_detail/event_city_detail_route.dart';
import 'package:cfit/view/ui/screens/event_public_detail/event_public_detail_arguments.dart';
import 'package:cfit/view/ui/screens/event_public_detail/event_public_detail_route.dart';
import 'package:cfit/view/ui/screens/home/home_route.dart';
import 'package:cfit/view/ui/screens/login/login_route.dart';
import 'package:cfit/view/ui/screens/my_datas/my_datas_arguments.dart';
import 'package:cfit/view/ui/screens/my_datas/my_datas_route.dart';
import 'package:cfit/view/ui/screens/my_event/my_event_arguments.dart';
import 'package:cfit/view/ui/screens/my_event/my_event_route.dart';
import 'package:cfit/view/ui/screens/register/register_route.dart';
import 'package:cfit/view/ui/screens/select_localization/select_localization_arguments.dart';
import 'package:cfit/view/ui/screens/select_localization/select_localization_route.dart';
import 'package:cfit/view/ui/screens/splash/splash_route.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  final arguments = settings.arguments;
  switch (settings.name) {
    case Routes.splash:
      return const SplashRoute().buildRoute();
    case Routes.login:
      return const LoginRoute().buildRoute();
    case Routes.register:
      return const RegisterRoute().buildRoute();
    case Routes.home:
      return const HomeRoute().buildRoute();
    case Routes.my_datas:
      final myDatasArguments = MyDataArguments.fromJson(arguments as String);
      return MyDatasRoute(user: myDatasArguments.user).buildRoute();
    case Routes.event_city_details:
      final eventDetailsArguments =
          EventCityDetailsArguments.fromJson(arguments as String);
      return EventCityDetailsRoute(
        eventCity: eventDetailsArguments.eventCity,
        alreadyScheduled: eventDetailsArguments.alreadyConfirmed,
        user: eventDetailsArguments.user,
      ).buildRoute();
    case Routes.event_public_details:
      final eventDetailsArguments =
          EventPublicDetailsArguments.fromJson(arguments as String);
      return EventPublicDetailsRoute(
        eventPublic: eventDetailsArguments.eventPublic,
        alreadyScheduled: eventDetailsArguments.alreadyConfirmed,
        user: eventDetailsArguments.user,
      ).buildRoute();
    case Routes.eventos_confirmations:
      final myEventArguments = MyEventArguments.fromJson(arguments as String);
      return MyEventRoute(eventCity: myEventArguments.eventCity).buildRoute();
    case Routes.event_city_admin:
      final eventCityAdminArguments =
          EventCityAdminArguments.fromJson(arguments as String);
      return EventCityAdminRoute(eventCity: eventCityAdminArguments.eventCity)
          .buildRoute();
    case Routes.map:
      final selectLocationArguments =
          SelectLocalizationArguments.fromJson(arguments as String);
      return SelectLocalizationRoute(
        toCreateEvent: selectLocationArguments.toCreateEvent,
      ).buildRoute<Address?>();
    default:
  }
  return const LoginRoute().buildRoute();
}

extension on Widget {
  Route<T> buildRoute<T>() {
    return MaterialPageRoute(builder: (_) => this);
  }
}
