import 'package:cfit/view/common/button.dart';
import 'package:cfit/view/common/modais.dart';
import 'package:cfit/view/common/padding.dart';
import 'package:flutter/material.dart';

class ScheduleErrorModal extends Modal {
  const ScheduleErrorModal({
    Key? key,
    required this.isUnscheduled,
    required this.onPressed,
  }) : super(key: key);

  final bool isUnscheduled;
  final VoidCallback onPressed;

  @override
  double get fraction => 0.4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.close,
            color: Colors.grey,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isUnscheduled
                  ? 'Falha ao tentar desagendar'
                  : 'Falha no agendamento',
              style: const TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ).withPaddingOnly(bottom: 16),
            Expanded(
              child: Text(
                isUnscheduled
                    ? '''Aconteceu algum problema ao fazer o seu desagendamento. Por favor tente novamente mais tarde.'''
                    : '''Aconteceu algum problema ao fazer o seu agendamento. Por favor tente novamente mais tarde.''',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 115,
        child: ButtonAction(
          text: 'Tentar novamente',
          type: ButtonActionType.primary,
          onPressed: onPressed,
          customBackgroundColor: Theme.of(context).primaryColor,
        ).withPaddingOnly(bottom: 36),
      ),
    );
  }
}

class ScheduleConfirmation extends Modal {
  const ScheduleConfirmation({
    Key? key,
    required this.onPressed,
    required this.isUnscheduled,
  }) : super(key: key);
  final VoidCallback onPressed;
  final bool isUnscheduled;

  @override
  double get fraction => 0.4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.close,
            color: Colors.grey,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isUnscheduled
                  ? 'Desagendamento realizado!'
                  : 'Agendamento confirmado!',
              style: const TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ).withPaddingOnly(bottom: 16),
            Expanded(
              child: Text(
                isUnscheduled
                    ? ''
                    : '''Não se esqueça de adicionar na sua agenda.''',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 115,
        child: ButtonAction(
          text: 'Fechar',
          type: ButtonActionType.primary,
          onPressed: onPressed,
          customBackgroundColor: Theme.of(context).primaryColor,
        ).withPaddingOnly(bottom: 36),
      ),
    );
  }
}
