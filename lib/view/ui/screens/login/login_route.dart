import 'package:cfit/view/ui/screens/login/login_cubit.dart';
import 'package:cfit/view/ui/screens/login/login_navigation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/build_context.dart';
import 'login_screen.dart';

class LoginRoute extends StatelessWidget {
  const LoginRoute({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        context.loginUseCase(),
        LoginNavigation.fromMaterialNavigation(Navigator.of(context)),
      ),
      child: const LoginScreen(),
    );
  }
}
