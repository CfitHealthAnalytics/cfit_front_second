import 'package:cfit/di/build_context.dart';
import 'package:cfit/view/ui/screens/home/home_navigation.dart';
import 'package:flutter/widgets.dart';

import 'home_controller.dart';
import 'home_screen.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScreen(
      controller: HomeController(
        feedUseCase: context.feedUseCase(),
        navigation: HomeNavigation.fromMaterialNavigation(
          Navigator.of(context),
        ),
      ),
    );
  }
}
