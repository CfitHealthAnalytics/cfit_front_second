import 'package:cfit/domain/models/user.dart';
import 'package:cfit/util/routes.dart';
import 'package:cfit/view/ui/screens/complete_account/complete_account_arguments.dart';
import 'package:cfit/view/ui/screens/home/home_arguments.dart';
import 'package:flutter/widgets.dart';

class SplashNavigation {
  final void Function() toLogin;
  final void Function({User? user, int? initialTab}) toHome;
  final void Function() toGenericError;
  final void Function(
      {required ConectaUser conectaUser,
      required int initialTab}) toCompleteLogin;

  SplashNavigation({
    required this.toLogin,
    required this.toHome,
    required this.toCompleteLogin,
    required this.toGenericError,
  });

  factory SplashNavigation.fromMaterialNavigation(
    NavigatorState navigator,
  ) {
    return SplashNavigation(
      toLogin: () => navigator.pushReplacementNamed(Routes.login),
      toHome: ({
        User? user,
        int? initialTab,
      }) {
        print('initialTab: $initialTab');
        navigator.pushReplacementNamed(Routes.home,
            arguments: HomeArguments(
              user: user,
              initialTab: initialTab,
            ).toJson());
      },
      toCompleteLogin: ({
        required ConectaUser conectaUser,
        required int initialTab,
      }) =>
          navigator.pushReplacementNamed(
        Routes.complete_account,
        arguments: CompleteAccountArguments(
                conectaUser: conectaUser, initialTab: initialTab)
            .toJson(),
      ),
      toGenericError: () =>
          navigator.pushReplacementNamed(Routes.generic_error),
    );
  }
}
