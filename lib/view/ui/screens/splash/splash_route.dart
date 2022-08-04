import 'package:cfit/di/build_context.dart';
import 'package:cfit/view/ui/screens/splash/splash_navigation.dart';
import 'package:flutter/widgets.dart';

import 'splash_controller.dart';
import 'splash_screen.dart';

class SplashRoute extends StatelessWidget {
  const SplashRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      controller: SplashController(
        initializationUseCase: context.initializationUseCase(),
        navigation: SplashNavigation.fromMaterialNavigation(
          Navigator.of(context),
        ),
      ),
    );
  }
}
