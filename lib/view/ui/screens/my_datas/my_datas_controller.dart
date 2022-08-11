import 'package:cfit/domain/use_cases/logout_use_case.dart';

import 'my_datas_navigation.dart';

class MyDatasController {
  MyDatasController(
    this._navigation,
    this._logoutUseCase,
  );
  final LogoutUseCase _logoutUseCase;

  final MyDataNavigation _navigation;

  void onBack() {
    _navigation.onBack();
  }

  void logout() async {
    await _logoutUseCase();
    _navigation.toLogin();
  }
}
