import 'package:cfit/util/routes.dart';
import 'package:cfit/view/ui/screens/event_city_admin/event_city_admin_arguments.dart';
import 'package:cfit/view/ui/screens/event_city_admin/event_city_admin_route.dart';
import 'package:cfit/view/ui/screens/event_detail/event_details_arguments.dart';
import 'package:cfit/view/ui/screens/event_detail/event_details_route.dart';
import 'package:cfit/view/ui/screens/home/home_route.dart';
import 'package:cfit/view/ui/screens/login/login_route.dart';
import 'package:cfit/view/ui/screens/my_datas/my_datas_arguments.dart';
import 'package:cfit/view/ui/screens/my_datas/my_datas_route.dart';
import 'package:cfit/view/ui/screens/my_event/my_event_arguments.dart';
import 'package:cfit/view/ui/screens/my_event/my_event_route.dart';
import 'package:cfit/view/ui/screens/register/register_route.dart';
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
    case Routes.event_details:
      final eventDetailsArguments =
          EventDetailsArguments.fromJson(arguments as String);
      return EventDetailsRoute(
        eventCity: eventDetailsArguments.eventCity,
        alreadyScheduled: eventDetailsArguments.alreadyConfirmed,
      ).buildRoute();
    case Routes.eventos_confirmations:
      final myEventArguments = MyEventArguments.fromJson(arguments as String);
      return MyEventRoute(eventCity: myEventArguments.eventCity).buildRoute();
    case Routes.event_city_admin:
      final eventCityAdminArguments =
          EventCityAdminArguments.fromJson(arguments as String);
      return EventCityAdminRoute(eventCity: eventCityAdminArguments.eventCity)
          .buildRoute();
    default:
  }
  return const LoginRoute().buildRoute();
}

extension on Widget {
  Route<dynamic> buildRoute() {
    return MaterialPageRoute(builder: (_) => this);
  }
}
