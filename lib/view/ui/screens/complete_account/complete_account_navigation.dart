import 'package:cfit/domain/models/user.dart';
import 'package:cfit/util/routes.dart';
import 'package:cfit/view/ui/screens/home/home_arguments.dart';
import 'package:flutter/widgets.dart';

class CompleteAccountNavigation {
  final void Function() toRegister;
  final void Function({User? user, int? initialTab}) toHome;
  final void Function() goBack;

  CompleteAccountNavigation({
    required this.toRegister,
    required this.toHome,
    required this.goBack,
  });

  factory CompleteAccountNavigation.fromMaterialNavigation(
    NavigatorState navigator,
  ) {
    return CompleteAccountNavigation(
      goBack: navigator.pop,
      toRegister: () => navigator.pushNamed(Routes.register),
      toHome: ({User? user, int? initialTab}) => navigator.pushReplacementNamed(
        Routes.home,
        arguments: HomeArguments(
          initialTab: initialTab,
          user: user,
        ).toJson(),
      ),
    );
  }
}
