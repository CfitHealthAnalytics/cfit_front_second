import 'package:cfit/domain/auth/auth.repository.dart';
import 'package:cfit/domain/core/exceptions/user_not_found.exception.dart';
import 'package:cfit/domain/core/utils/snackbar.util.dart';
import 'package:cfit/presentation/shared/loading/loading.controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PerfilController extends GetxController {
  final AuthRepository _authRepository;
  final _loadingController = Get.find<LoadingController>();
  PerfilController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  Future<void> doCadatro() async {
    try {
      print('Processa Mensagem');
      _loadingController.isLoading = true;
      if (validateFields()) {
        //Get.focusScope?.unfocus();

        /*
        await _authRepository.authenticateUser(
          login: login.value,
          password: password.value,
        );
        Get.offAllNamed(Routes.home);
        */

        _loadingController.isLoading = false;
      }
    } on UserNotFoundException catch (err) {
      SnackbarUtil.showWarning(message: err.toString());
    } catch (err) {
      SnackbarUtil.showError(message: err.toString());
    } finally {
      _loadingController.isLoading = false;
    }
  }

  bool validateFields() {
    validateCidade(cidade.value);
    //validateLogin(login.value);
    //validatePassword(password.value);

    return cidade.isNotEmpty && cidadeError.value == null;
  }

  final cidade = ''.obs;
  final cidadeError = RxnString();
  final cidadeFocus = FocusNode();
  void validateCidade(String val) {
    if (val.isEmpty) {
      cidadeError.value = 'Campo Obrigatório';
    } else if (val.length < 3) {
      cidadeError.value =
          'Nome da Cidade precisa de pelo menos 3 caracteristicas.';
    } else {
      cidadeError.value = null;
    }
  }

  final bairro = ''.obs;
  final bairroError = RxnString();
  final bairroFocus = FocusNode();
  void validateBairro(String val) {
    if (val.isEmpty) {
      cidadeError.value = 'Campo Obrigatório';
    } else if (val.length < 3) {
      cidadeError.value =
          'Nome do bairro precisa de pelo menos 3 caracteristicas.';
    } else {
      cidadeError.value = null;
    }
  }

  final rua = ''.obs;
  final ruaError = RxnString();
  final ruaFocus = FocusNode();
  void validateRua(String val) {
    if (val.isEmpty) {
      ruaError.value = 'Campo Obrigatório';
    } else if (val.length < 3) {
      ruaError.value = 'Nome do Rua precisa de pelo menos 3 caracteristicas.';
    } else {
      ruaError.value = null;
    }
  }

  final numero = ''.obs;
  final numeroError = RxnString();
  final numeroFocus = FocusNode();
  void validateNumero(String val) {
    if (val.isEmpty) {
      numeroError.value = 'Campo Obrigatório';
    } else {
      numeroError.value = null;
    }
  }

  final tipoevento = ''.obs;
  final tipoeventoError = RxnString();
  final tipoeventoFocus = FocusNode();
  void validateTipoEvento(String val) {
    if (val.isEmpty) {
      tipoeventoError.value = 'Campo Obrigatório';
    } else if (val.length < 3) {
      tipoeventoError.value =
          'Digite o numero da Rua precisa de pelo menos 3 caracteristicas.';
    } else {
      tipoeventoError.value = null;
    }
  }

  final qtdPessoas = ''.obs;
  final qtdPessoasError = RxnString();
  final qtdPessoasFocus = FocusNode();
  void validateQtdPessoas(String val) {
    if (val.isEmpty) {
      numeroError.value = 'Campo Obrigatório';
    } else if (val.length < 3) {
      numeroError.value =
          'Digite o numero da Rua precisa de pelo menos 3 caracteristicas.';
    } else {
      numeroError.value = null;
    }
  }

  final descricao = ''.obs;
  final descricaoError = RxnString();
  final descricaoFocus = FocusNode();
  void validateDescricao(String val) {
    if (val.isEmpty) {
      descricaoError.value = 'Campo Obrigatório';
    } else if (val.length < 3) {
      descricaoError.value =
          'Digite o numero da Rua precisa de pelo menos 3 caracteristicas.';
    } else {
      descricaoError.value = null;
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

  bool get enableButton => cidade.isNotEmpty && cidadeError.value != null;
}
