import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/build_context.dart';
import 'my_measures_cubit.dart';
import 'my_measures_navigation.dart';
import 'my_measures_screen.dart';

class MyMeasureRoute extends StatelessWidget {
  const MyMeasureRoute({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyMeasureCubit(
        context.bioInfoUseCase(),
        MyMeasureNavigation.fromMaterialNavigation(
          Navigator.of(context),
        ),
        context.getUser(),
      ),
      child: const MyMeasureScreen(),
    );
  }
}
