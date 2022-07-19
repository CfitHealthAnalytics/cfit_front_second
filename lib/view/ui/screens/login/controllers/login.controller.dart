import 'package:cfit/domain/auth/auth.repository.dart';
import 'package:cfit/domain/auth/models/user.model.dart';
import 'package:cfit/domain/core/constants/storage.constants.dart';
import 'package:cfit/domain/core/exceptions/user_not_found.exception.dart';
import 'package:cfit/domain/core/utils/snackbar.util.dart';
import 'package:cfit/helper/DialogHelper.dart';
import 'package:cfit/infrastructure/navigation/routes.dart';
import 'package:cfit/presentation/shared/loading/loading.controller.dart';
import 'package:cfit/util/app_constants.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository;
  final _loadingController = Get.find<LoadingController>();
  LoginController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  final _storage = Get.find<GetStorage>();

  @override
  void onInit() {
    super.onInit();
    ever<String>(login, validateLogin);
    ever<String>(password, validatePassword);
  }

  Future<void> doLogin() async {
    DialogHelper.showLoading();
    try {
      _loadingController.isLoading = false;
      if (validateFields()) {
        //Get.focusScope?.unfocus();
        Response response = await _authRepository.authenticateUser(
          login: login.value,
          password: password.value,
        );

        if (response.statusCode == 200) {
          UserModel user = UserModel(
              kind: response.body['kind'],
              localId: response.body['localId'],
              email: response.body['email'],
              idToken: response.body['idToken'],
              refreshToken: response.body['refreshToken'],
              expiresIn: response.body['expiresIn']);

          await user.save();

          await _storage.write(
            StorageConstants.tokenAuthorization,
            response.body['idToken'],
          );

          await _storage.write(
            AppConstants.REFRESH_TOKEN,
            response.body['refreshToken'],
          );

          if (_storage.read(StorageConstants.tokenAuthorization) != '') {
            Get.toNamed(Routes.dashboard);
            //Get.find<AuthController>().getUser();
          } else {
            //print('Token');

            DialogHelper.hideLoading();
            SnackbarUtil.showWarning(
                message: 'Tivemos um problema ao realizar o login.');
          }
        } else {
          //DialogHelper.hideLoading();
          /*
          DialogHelper.showErroDialog(
              title: 'Opps', description: 'E-mail ou senha não confere.');*/
          SnackbarUtil.showWarning(message: 'E-mail ou senha não confere.');
        }
        _loadingController.isLoading = false;
      } else {
        SnackbarUtil.showWarning(message: 'Valide os campos para continuar');
      }
    } on UserNotFoundException {
      DialogHelper.hideLoading();
      SnackbarUtil.showWarning(message: 'Login ou senha inválidos');
    } catch (err) {
      DialogHelper.hideLoading();
      SnackbarUtil.showError(message: 'Login ou senha inválidos');
    } finally {
      _loadingController.isLoading = false;
      //DialogHelper.hideLoading();
    }
  }

  bool validateFields() {
    validateLogin(login.value);
    validatePassword(password.value);

    return login.isNotEmpty &&
        password.isNotEmpty &&
        loginError.value == null &&
        passwordError.value == null;
  }

  final login = ''.obs;
  final loginError = RxnString();
  final loginFocus = FocusNode();
  void validateLogin(String val) {
    if (val.isEmpty) {
      loginError.value = 'Digite seu E-mail';
    } else if (val.length < 3) {
      loginError.value = 'E-mail inválido';
    } else {
      loginError.value = null;
    }
  }

  final password = ''.obs;
  final passwordError = RxnString();
  final passwordFocus = FocusNode();
  void validatePassword(String val) {
    if (val.isEmpty) {
      passwordError.value = 'Digite sua senha';
    } else if (val.length < 3) {
      passwordError.value = 'Senha inválida, no mínimo 3 caracters.';
    } else {
      passwordError.value = null;
    }
  }

  bool get enableButton =>
      login.isNotEmpty &&
      password.isNotEmpty &&
      loginError.value != null &&
      passwordError.value != null;
}
