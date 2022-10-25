import 'package:cfit/di/build_context.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'map_cubit.dart';
import 'map_navigation.dart';
import 'map_screen.dart';

class MapRoute extends StatelessWidget {
  const MapRoute({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapCubit(
        MapNavigation.fromMaterialNavigation(
          Navigator.of(context),
        ),
        context.getPolesUseCase(),
      ),
      child: const MapScreen(),
    );
  }
}
