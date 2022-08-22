import 'package:cfit/view/common/button.dart';
import 'package:cfit/view/common/modais.dart';
import 'package:flutter/material.dart';

class RegisterErrorModal implements Modal {
  RegisterErrorModal({
    required this.onPressed,
    required this.context,
  });

  final VoidCallback onPressed;
  final BuildContext context;

  @override
  double get fraction => 0.45;

  @override
  Widget? get primaryAction => ButtonAction(
        text: 'Tentar novamente',
        type: ButtonActionType.primary,
        onPressed: onPressed,
        customBackgroundColor: Theme.of(context).primaryColor,
      );

  @override
  Widget? get secondaryAction => null;

  @override
  Widget? get subtitle => const Text(
        '''Aconteceu algum problema com as informações inseridas. Por favor verifique os valores inseridos, e tente novamente.''',
        style: TextStyle(
          fontSize: 20,
        ),
      );

  @override
  Widget get title => const Text(
        'Falha no Register',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      );
}

class RegisterErrorAlreadyExistsModal implements Modal {
  const RegisterErrorAlreadyExistsModal({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  double get fraction => 0.45;

  @override
  Widget? get primaryAction => ButtonAction(
        text: 'Entrar',
        type: ButtonActionType.primary,
        onPressed: onPressed,
      );

  @override
  Widget? get secondaryAction => throw UnimplementedError();

  @override
  Widget? get subtitle => const Text(
        '''Esse email já está cadastrado nos nossos sistemas. Tente usar o outro email, para realizar o cadastro, ou tente fazer o login usando esse email pressionando o botão abaixo''',
        style: TextStyle(
          fontSize: 20,
        ),
      );

  @override
  Widget get title => const Text(
        'Parece que esse email já existe',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      );
}
