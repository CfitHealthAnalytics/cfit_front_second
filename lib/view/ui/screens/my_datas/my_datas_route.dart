import 'package:cfit/di/build_context.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/view/ui/screens/my_datas/my_datas_controller.dart';
import 'package:cfit/view/ui/screens/my_datas/my_datas_navigation.dart';
import 'package:flutter/widgets.dart';

import 'my_datas_screen.dart';

class MyDatasRoute extends StatelessWidget {
  const MyDatasRoute({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return MyDatasScreen(
      controller: MyDatasController(
        MyDataNavigation.fromMaterialNavigation(
          Navigator.of(context),
        ),
        context.logoutUseCase(),
      ),
      user: user,
    );
  }
}
