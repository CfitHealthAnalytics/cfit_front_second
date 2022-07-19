import 'package:cfit/view/ui/screens/MyMeasures/mymeasures.screen.dart';
import 'package:cfit/view/ui/screens/dashboard/dashboard.dart';
import 'package:cfit/view/ui/screens/events.dart';
import 'package:cfit/view/ui/screens/events/event_edit.dart';
import 'package:cfit/view/ui/screens/events/eventdetail.dart';
import 'package:cfit/view/ui/screens/events/events_favorite.dart';
import 'package:cfit/view/ui/screens/events/models/Events.models.dart';
import 'package:cfit/view/ui/screens/forgot/forgot.screen.dart';
import 'package:cfit/view/ui/screens/maps/maps_events.dart';
import 'package:cfit/view/ui/screens/perfil/perfil.dart';
import 'package:cfit/view/ui/screens/qr_code/qr_code.dart';
import 'package:cfit/view/ui/screens/register/register.screen.dart';
import 'package:cfit/view/ui/screens/splash/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class Nav {
  bool exitFromApp = true;

  static List<GetPage> routes = [
    GetPage(
      name: Routes.splash,
      page: () => SplashPage(),
      binding: DependenciesControllerBinding(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardScreen(pageIndex: 0),
      binding: DependenciesControllerBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      binding: DependenciesControllerBinding(),
    ),
    GetPage(
      name: Routes.forgot,
      page: () => ForgotScreen(),
      binding: DependenciesControllerBinding(),
    ),
    GetPage(
      name: Routes.cadastro,
      page: () => const RegisterScreen(exitFromApp: true),
      binding: DependenciesControllerBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
      binding: DependenciesControllerBinding(),
    ),
    GetPage(
      name: Routes.eventos,
      page: () => EventsScreen(),
      binding: DependenciesControllerBinding(),
    ),
    GetPage(
        name: Routes.eventos_editar,
        page: () {
          return getRoute(
            Get.arguments ??
                EventEdit(
                  event: EventsModel(id: Get.parameters['id'] ?? ''),
                ),
          );
        }),
    GetPage(
      name: Routes.eventos_detalhe,
      page: () => EventDetail(),
      binding: DependenciesControllerBinding(),
    ),
    GetPage(
      name: Routes.eventos_favorite,
      page: () => EventsFavoriteScreen(),
      binding: DependenciesControllerBinding(),
    ),
    GetPage(
      name: Routes.cadastro_eventos,
      page: () => HomeScreen(),
      binding: DependenciesControllerBinding(),
    ),
    GetPage(
      name: Routes.perfil,
      page: () => PerfilScreen(),
      binding: DependenciesControllerBinding(),
    ),
    GetPage(
      name: Routes.mymeasures,
      page: () => MyMeasuresScreen(),
      binding: DependenciesControllerBinding(),
    ),
    GetPage(
      name: Routes.mapa,
      page: () => EventsMaps(),
      binding: DependenciesControllerBinding(),
    ),
    GetPage(
      name: Routes.qrcode,
      page: () => const QRCodeScanner(),
      binding: DependenciesControllerBinding(),
    ),
  ];

  static getRoute(Widget navigateTo) {
    int _minimumVersion = 0;
    return navigateTo;
  }
}
