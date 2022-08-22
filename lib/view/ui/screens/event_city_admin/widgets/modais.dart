import 'package:cfit/view/common/button.dart';
import 'package:cfit/view/common/modais.dart';
import 'package:flutter/material.dart';

class ConfirmationErrorModal implements Modal {
  const ConfirmationErrorModal({
    Key? key,
  });

  @override
  double get fraction => 0.4;

  @override
  Widget? get primaryAction => null;

  @override
  Widget? get secondaryAction => null;

  @override
  Widget? get subtitle => const Text(
        '''Aconteceu algum problema ao fazer a confirmação de presença. Por favor tente novamente mais tarde.''',
        style: TextStyle(
          fontSize: 20,
        ),
      );

  @override
  Widget get title => const Text(
        'Falha na confirmação',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      );
}

class ConfirmationSucceeds implements Modal {
  const ConfirmationSucceeds({
    Key? key,
    required this.onPressed,
    required this.context,
  });
  final VoidCallback onPressed;
  final BuildContext context;

  @override
  double get fraction => 0.4;

  @override
  Widget? get primaryAction => ButtonAction(
        text: 'Fechar',
        type: ButtonActionType.primary,
        onPressed: onPressed,
        customBackgroundColor: Theme.of(context).primaryColor,
      );

  @override
  Widget? get secondaryAction => null;

  @override
  Widget? get subtitle => const Text(
        '''Muito obrigado por realizar a confirmação de presença dos seus alunos, e boa aula''',
        style: TextStyle(
          fontSize: 20,
        ),
      );

  @override
  Widget get title => const Text(
        'Confirmação de presença realizada!',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      );
}
