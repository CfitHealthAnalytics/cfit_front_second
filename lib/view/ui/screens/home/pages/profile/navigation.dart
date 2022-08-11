import 'package:cfit/domain/models/user.dart';
import 'package:cfit/util/routes.dart';
import 'package:flutter/material.dart';

import '../../../my_datas/my_datas_arguments.dart';

class ProfileNavigation {
  final void Function(User user) toMyDatas;

  ProfileNavigation({
    required this.toMyDatas,
  });

  factory ProfileNavigation.fromMaterialNavigator(NavigatorState navigator) {
    return ProfileNavigation(
      toMyDatas: (User user) => navigator.pushNamed(
        Routes.my_datas,
        arguments: MyDataArguments.fromMap({
          'user': user.toMap(),
        }).toJson(),
      ),
    );
  }
}
