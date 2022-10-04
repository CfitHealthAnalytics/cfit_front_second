import 'package:cfit/di/build_context.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'complete_account_cubit.dart';
import 'complete_account_navigation.dart';
import 'complete_account_screen.dart';

class CompleteAccountRoute extends StatelessWidget {
  const CompleteAccountRoute({
    Key? key,
    required this.conectaUser,
    required this.initialTab,
  }) : super(key: key);

  final ConectaUser conectaUser;
  final int initialTab;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompleteAccountCubit(
        conectaUser: conectaUser,
        initialTab: initialTab,
        navigation: CompleteAccountNavigation.fromMaterialNavigation(
            Navigator.of(context)),
        completeAccountUseCase: context.completeAccountUseCase(),
      ),
      child: const CompleteAccountScreen(),
    );
  }
}
