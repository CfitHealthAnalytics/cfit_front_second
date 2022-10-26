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

bool fromConecta = false;

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  final arguments = settings.arguments;
  final name = settings.name?.split('?').first ?? settings.name ?? '/';
  switch (name) {
    case Routes.splash:
      return const SplashRoute().buildRoute(fromConecta: fromConecta);
    case Routes.conecta_events:
      final token = settings.name!.split('?').last.split('=').last;
      fromConecta = true;
      return SplashRoute(
        token: token,
        initialPage: 2,
      ).buildRoute(fromConecta: true);
    case Routes.conecta_profile:
      final token = settings.name!.split('?').last.split('=').last;
      fromConecta = true;
      return SplashRoute(
        token: token,
        initialPage: 3,
      ).buildRoute(fromConecta: true);
    case Routes.conecta_dashboard:
      final token = settings.name!.split('?').last.split('=').last;
      fromConecta = true;
      return SplashRoute(
        token: token,
        initialPage: 0,
      ).buildRoute(fromConecta: true);
    case Routes.conecta_gym:
      final token = settings.name!.split('?').last.split('=').last;
      fromConecta = true;
      return SplashRoute(
        token: token,
        initialPage: 1,
      ).buildRoute(fromConecta: true);
    case Routes.login:
      return const LoginRoute().buildRoute(fromConecta: fromConecta);
    case Routes.generic_error:
      return const GenericErrorRoute().buildRoute(fromConecta: fromConecta);
    case Routes.register:
      return const RegisterRoute().buildRoute(fromConecta: fromConecta);
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
      ).buildRoute(fromConecta: fromConecta);

    // TODO: remove this after
    // return const MapRoute().buildRoute(fromConecta: fromConecta);
    case Routes.my_measures:
      return const MyMeasureRoute().buildRoute(fromConecta: fromConecta);
    case Routes.recover_password:
      return const RecoverPasswordRoute().buildRoute(fromConecta: fromConecta);
    case Routes.complete_account:
      final completeAccountArguments =
          CompleteAccountArguments.fromJson(arguments as String);
      return CompleteAccountRoute(
        conectaUser: completeAccountArguments.conectaUser,
        initialTab: completeAccountArguments.initialTab,
      ).buildRoute(fromConecta: fromConecta);
    case Routes.my_datas:
      final myDatasArguments = MyDataArguments.fromJson(arguments as String);
      return MyDatasRoute(user: myDatasArguments.user)
          .buildRoute(fromConecta: fromConecta);
    case Routes.event_city_details:
      final eventDetailsArguments =
          EventCityDetailsArguments.fromJson(arguments as String);
      return EventCityDetailsRoute(
        eventCity: eventDetailsArguments.eventCity,
        alreadyScheduled: eventDetailsArguments.alreadyConfirmed,
        user: eventDetailsArguments.user,
      ).buildRoute(fromConecta: fromConecta);
    case Routes.event_public_details:
      final eventDetailsArguments =
          EventPublicDetailsArguments.fromJson(arguments as String);
      return EventPublicDetailsRoute(
        eventPublic: eventDetailsArguments.eventPublic,
        alreadyScheduled: eventDetailsArguments.alreadyConfirmed,
        user: eventDetailsArguments.user,
      ).buildRoute(fromConecta: fromConecta);
    case Routes.event_public_admin:
      final myEventArguments = MyEventArguments.fromJson(arguments as String);
      return MyEventRoute(
        eventPublic: myEventArguments.eventPublic,
        user: myEventArguments.user,
      ).buildRoute(fromConecta: fromConecta);
    case Routes.event_city_admin:
      final eventCityAdminArguments =
          EventCityAdminArguments.fromJson(arguments as String);
      return EventCityAdminRoute(eventCity: eventCityAdminArguments.eventCity)
          .buildRoute(fromConecta: fromConecta);
    case Routes.map:
      final selectLocationArguments =
          SelectLocalizationArguments.fromJson(arguments as String);
      return SelectLocalizationRoute(
        toCreateEvent: selectLocationArguments.toCreateEvent,
        user: selectLocationArguments.user,
      ).buildRoute<SelectLocalizationResponse?>(fromConecta: fromConecta);
    default:
  }
  return const LoginRoute().buildRoute(fromConecta: fromConecta);
}

extension on Widget {
  Route<T> buildRoute<T>({bool? fromConecta}) {
    if (fromConecta == true) {
      return MaterialPageRoute(
        builder: (_) => Banner(
          message: 'VERSÃO\n' 'BETA',
          location: BannerLocation.topEnd,
          child: this,
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 12 * 0.85,
            fontWeight: FontWeight.w900,
            height: 1.0,
          ),
        ),
      );
    }
    return MaterialPageRoute(builder: (_) => this);
  }
}
