import 'package:flutter/widgets.dart';

import 'register_controller.dart';
import 'register_screen.dart';

class RegisterRoute extends StatelessWidget {
  const RegisterRoute({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RegisterScreen(
      controller: RegisterController(),
    );
  }
}
