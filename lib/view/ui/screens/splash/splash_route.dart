import 'package:cfit/di/build_context.dart';
import 'package:cfit/view/ui/screens/splash/splash_navigation.dart';
import 'package:flutter/widgets.dart';

import 'splash_controller.dart';
import 'splash_screen.dart';

enum SplashInitialization { normal, connect }

class SplashRoute extends StatelessWidget {
  const SplashRoute(
      {Key? key,
      this.initializationType = SplashInitialization.normal,
      this.token,
      this.initialPage})
      : super(key: key);

  final SplashInitialization initializationType;
  final String? token;
  final int? initialPage;

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      controller: SplashController(
        token: token,
        initialPage: initialPage,
        initializationUseCase: context.initializationUseCase(),
        initializationByConectaUseCase:
            context.initializationByConectaUseCase(),
        navigation: SplashNavigation.fromMaterialNavigation(
          Navigator.of(context),
        ),
        autoConfigureUserUseCase: context.autoConfigureUserUseCase(),
      ),
    );
  }
}
