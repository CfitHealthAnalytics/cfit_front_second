import 'package:cfit/di/build_context.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/view/ui/screens/home/home_navigation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_cubit.dart';
import 'home_screen.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({
    Key? key,
    this.user,
    this.initialTab,
  }) : super(key: key);

  final User? user;
  final int? initialTab;

  @override
  Widget build(BuildContext context) {
    print('initialTab: $initialTab');
    return BlocProvider(
      create: (context) => HomeCubit(
        feedUseCase: context.feedUseCase(),
        eventsInCityUseCase: context.eventsInCityUseCase(),
        eventsPublicUseCase: context.eventsPublicUseCase(),
        navigation: HomeNavigation.fromMaterialNavigation(
          Navigator.of(context),
        ),
        user: user,
        initialTab: initialTab,
      ),
      child: const HomeScreen(),
    );
  }
}
