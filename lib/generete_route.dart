import 'package:cfit/util/routes.dart';
import 'package:cfit/view/ui/screens/complete_account/complete_account_arguments.dart';
import 'package:cfit/view/ui/screens/complete_account/complete_account_route.dart';
import 'package:cfit/view/ui/screens/event_city_admin/event_city_admin_arguments.dart';
import 'package:cfit/view/ui/screens/event_city_admin/event_city_admin_route.dart';
import 'package:cfit/view/ui/screens/event_city_detail/event_city_detail_arguments.dart';
import 'package:cfit/view/ui/screens/event_city_detail/event_city_detail_route.dart';
import 'package:cfit/view/ui/screens/event_public_detail/event_public_detail_arguments.dart';
import 'package:cfit/view/ui/screens/event_public_detail/event_public_detail_route.dart';
import 'package:cfit/view/ui/screens/home/home_arguments.dart';
import 'package:cfit/view/ui/screens/home/home_route.dart';
import 'package:cfit/view/ui/screens/login/login_route.dart';
import 'package:cfit/view/ui/screens/my_datas/my_datas_arguments.dart';
import 'package:cfit/view/ui/screens/my_datas/my_datas_route.dart';
import 'package:cfit/view/ui/screens/my_event/my_event_arguments.dart';
import 'package:cfit/view/ui/screens/my_event/my_event_route.dart';
import 'package:cfit/view/ui/screens/my_measures/my_measures_route.dart';
import 'package:cfit/view/ui/screens/recover_password/recover_password_route.dart';
import 'package:cfit/view/ui/screens/register/register_route.dart';
import 'package:cfit/view/ui/screens/select_localization/select_localization_arguments.dart';
import 'package:cfit/view/ui/screens/select_localization/select_localization_response.dart';
import 'package:cfit/view/ui/screens/select_localization/select_localization_route.dart';
import 'package:cfit/view/ui/screens/splash/splash_route.dart';
import 'package:flutter/material.dart';

import 'view/ui/screens/generic_error/generic_error_route.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  final arguments = settings.arguments;
  final name = settings.name?.split('?').first ?? settings.name ?? '/';
  print('name: $name');
  switch (name) {
    case Routes.splash:
      return SplashRoute().buildRoute();
    case Routes.conecta_events:
      final token = settings.name!.split('?').last.split('=').last;
      return SplashRoute(
        token: token,
      ).buildRoute();
    case Routes.login:
      return const LoginRoute().buildRoute();
    case Routes.generic_error:
      return const GenericErrorRoute().buildRoute();
    case Routes.register:
      return const RegisterRoute().buildRoute();
    case Routes.home:
      HomeArguments homeArguments;
      if (arguments != null) {
        homeArguments = HomeArguments.fromJson(arguments as String);
      } else {
        homeArguments = HomeArguments();
      }

      return HomeRoute(
        user: homeArguments.user,
        initialTab: homeArguments.initialTab,
      ).buildRoute();
    case Routes.my_measures:
      return const MyMeasureRoute().buildRoute();
    case Routes.recover_password:
      return const RecoverPasswordRoute().buildRoute();
    case Routes.complete_account:
      final completeAccountArguments =
          CompleteAccountArguments.fromJson(arguments as String);
      return CompleteAccountRoute(
        conectaUser: completeAccountArguments.conectaUser,
        initialTab: completeAccountArguments.initialTab,
      ).buildRoute();
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
    case Routes.event_public_admin:
      final myEventArguments = MyEventArguments.fromJson(arguments as String);
      return MyEventRoute(
        eventPublic: myEventArguments.eventPublic,
        user: myEventArguments.user,
      ).buildRoute();
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
        user: selectLocationArguments.user,
      ).buildRoute<SelectLocalizationResponse?>();
    default:
  }
  return const LoginRoute().buildRoute();
}

extension on Widget {
  Route<T> buildRoute<T>() {
    return MaterialPageRoute(builder: (_) => this);
  }
}
