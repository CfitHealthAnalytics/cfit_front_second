import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/build_context.dart';
import 'recover_password_cubit.dart';
import 'recover_password_navigation.dart';
import 'recover_password_screen.dart';

class RecoverPasswordRoute extends StatelessWidget {
  const RecoverPasswordRoute({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecoverPasswordCubit(
        context.recoverPasswordUseCase(),
        RecoverPasswordNavigation.fromMaterialNavigation(Navigator.of(context)),
      ),
      child: const RecoverPasswordScreen(),
    );
  }
}
