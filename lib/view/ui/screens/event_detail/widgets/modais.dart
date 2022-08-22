import 'package:cfit/view/common/button.dart';
import 'package:cfit/view/common/modais.dart';
import 'package:flutter/material.dart';

class ScheduleErrorModal implements Modal {
  const ScheduleErrorModal({
    Key? key,
    required this.isUnscheduled,
    required this.context,
    required this.onPressed,
  });
  final bool isUnscheduled;
  final BuildContext context;
  final VoidCallback onPressed;

  @override
  double get fraction => 0.4;

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
  Widget? get subtitle => Text(
        isUnscheduled
            ? '''Aconteceu algum problema ao fazer o seu desagendamento. Por favor tente novamente mais tarde.'''
            : '''Aconteceu algum problema ao fazer o seu agendamento. Por favor tente novamente mais tarde.''',
        style: const TextStyle(
          fontSize: 20,
        ),
      );

  @override
  Widget get title => Text(
        isUnscheduled ? 'Falha ao tentar desagendar' : 'Falha no agendamento',
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      );
}

class ScheduleConfirmation implements Modal {
  const ScheduleConfirmation({
    Key? key,
    required this.onPressed,
    required this.isUnscheduled,
    required this.context,
  });
  final VoidCallback onPressed;
  final bool isUnscheduled;
  final BuildContext context;

  @override
  double get fraction => isUnscheduled ? 0.3 : 0.4;

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
  Widget? get subtitle => Text(
        isUnscheduled ? '' : '''Não se esqueça de adicionar na sua agenda.''',
        style: const TextStyle(
          fontSize: 20,
        ),
      );

  @override
  Widget get title => Text(
        isUnscheduled ? 'Desagendamento realizado!' : 'Agendamento confirmado!',
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      );
}
