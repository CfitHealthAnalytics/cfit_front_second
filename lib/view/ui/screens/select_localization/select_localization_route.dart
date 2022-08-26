import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'select_localization_cubit.dart';
import 'select_localization_navigation.dart';
import 'select_localization_screen.dart';

class SelectLocalizationRoute extends StatelessWidget {
  const SelectLocalizationRoute({
    Key? key,
    required this.toCreateEvent,
  }) : super(key: key);

  final bool toCreateEvent;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectLocalizationCubit(
        SelectLocalizationNavigation.fromMaterialNavigation(
          Navigator.of(context),
        ),
        toCreateEvent: toCreateEvent,
      ),
      child: const SelectLocalizationScreen(),
    );
  }
}
