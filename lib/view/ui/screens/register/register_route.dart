import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/build_context.dart';
import 'register_cubit.dart';
import 'register_navigation.dart';
import 'register_screen.dart';

class RegisterRoute extends StatelessWidget {
  const RegisterRoute({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
        context.registerUseCase(),
        RegisterNavigation.fromMaterialNavigation(
          Navigator.of(context),
        ),
      ),
      child: const RegisterScreen(),
    );
  }
}
