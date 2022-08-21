import 'package:cfit/di/build_context.dart';
import 'package:cfit/view/ui/screens/home/home_navigation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_cubit.dart';
import 'home_screen.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        feedUseCase: context.feedUseCase(),
        eventsInCityUseCase: context.eventsInCityUseCase(),
        navigation: HomeNavigation.fromMaterialNavigation(
          Navigator.of(context),
        ),
      ),
      child: const HomeScreen(),
    );
  }
}
