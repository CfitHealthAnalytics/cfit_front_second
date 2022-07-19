import 'package:cfit/domain/auth/auth.repository.dart';
import 'package:cfit/domain/auth/models/user.model.dart';
import 'package:cfit/domain/core/constants/storage.constants.dart';
import 'package:cfit/domain/core/exceptions/user_not_found.exception.dart';
import 'package:cfit/domain/core/utils/snackbar.util.dart';
import 'package:cfit/infrastructure/navigation/routes.dart';
import 'package:cfit/presentation/shared/loading/loading.controller.dart';

import 'package:cfit/helper/DialogHelper.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RegisterController extends GetxController {
  final AuthRepository _authRepository;
  final _loadingController = Get.find<LoadingController>();
  final _storage = Get.find<GetStorage>();

  bool continua = false;
  String MsgError =
      'Tivemos um problema ao realizar seu cadastro tente novamente.';

  RegisterController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  void onInit() {
    super.onInit();
    ever<String>(login, validateLogin);
    ever<String>(password, validatePassword);

    genero.value = 'Masculino';
  }

  Future<void> doRegister() async {
    DialogHelper.showLoading('');

    try {
      _loadingController.isLoading = true;
      if (validateFields()) {
        //Get.focusScope?.unfocus();

        Response retorno = await _authRepository.register(
          email: email.value,
          nome: nome.value,
          password: password.value,
          dataNascimento: datec.value,
          genero: genero.value == 'Masculino' ? 'masculino' : 'feminino',
        );

        if (retorno.statusCode == 200) {
          SnackbarUtil.showSuccess(
              message: 'Seu Cadastro foi realizado com sucesso.');

          final user = UserModel(
              kind: retorno.body['kind'],
              localId: retorno.body['localId'],
              email: retorno.body['email'],
              idToken: retorno.body['idToken'],
              refreshToken: retorno.body['refreshToken'],
              expiresIn: retorno.body['expiresIn']);
          await user.save();
          await _storage.write(
            StorageConstants.tokenAuthorization,
            retorno.body['idToken'],
          );

          Get.toNamed(Routes.dashboard);
        } else {
          DialogHelper.hideLoading();
          if (retorno.body['message'] == 'EMAIL_EXISTS') {
            SnackbarUtil.showWarning(
                message:
                    'E-mail informado já está cadastro, tente adicionar outro para continuar.',
                duration: const Duration(seconds: 10));
          } else {
            SnackbarUtil.showWarning(
                message: MsgError, duration: const Duration(seconds: 10));
          }
        }
        _loadingController.isLoading = false;
      } else {
        DialogHelper.hideLoading();
        SnackbarUtil.showError(
            message: 'Para continuar o cadastro por favor verifique os dados.',
            duration: const Duration(seconds: 10));
      }
    } on UserNotFoundException {
      SnackbarUtil.showWarning(
          message: MsgError, duration: const Duration(seconds: 10));
      _loadingController.isLoading = false;
    } catch (err) {
      SnackbarUtil.showError(
          message: MsgError, duration: const Duration(seconds: 10));
      _loadingController.isLoading = false;
    } finally {
      _loadingController.isLoading = false;
    }
  }

  bool validateFields() {
    //validateLogin(login.value);
    //uuvalidatePassword(password.value);

    return email.isNotEmpty &&
        password.isNotEmpty &&
        emailError.value == null &&
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

  final nome = ''.obs;
  final nomeError = RxnString();
  final nomeFocus = FocusNode();

  final email = ''.obs;
  final emailError = RxnString();
  final emailFocus = FocusNode();

  final datec = ''.obs;
  final datecError = RxnString();
  final datecFocus = FocusNode();

  final genero = ''.obs;
  final generoError = RxnString();
  final generoFocus = FocusNode();

  final sexo = ''.obs;
  final sexoError = RxnString();
  final sexoFocus = FocusNode();

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

  final cpassword = ''.obs;
  final cpasswordError = RxnString();
  final cpasswordFocus = FocusNode();
  void validateCPassword(String val) {
    if (val.isEmpty) {
      cpasswordError.value = 'Digite sua senha';
    } else if (val.length < 3) {
      cpasswordError.value = 'Senha inválida, no mínimo 3 caracters.';
    } else {
      cpasswordError.value = null;
    }
  }

  bool get enableButton =>
      login.isNotEmpty &&
      password.isNotEmpty &&
      loginError.value != null &&
      passwordError.value != null;

  void _singUp() async {
    bool _isValid = GetPlatform.isWeb ? true : false;
    if (!GetPlatform.isWeb) {
      try {
        //PhoneNumber phoneNumber = await PhoneNumberUtil().parse(_numberWithCountryCode);
        //_numberWithCountryCode = '+' + phoneNumber.countryCode + phoneNumber.nationalNumber;
        _isValid = true;
      } catch (e) {}
    }
  }
}
