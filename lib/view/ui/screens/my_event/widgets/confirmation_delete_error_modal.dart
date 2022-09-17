import 'package:cfit/view/common/button.dart';
import 'package:cfit/view/common/modais.dart';
import 'package:cfit/view/common/padding.dart';
import 'package:flutter/material.dart';

class ConfirmDeleteErrorModal extends Modal {
  const ConfirmDeleteErrorModal({
    Key? key,
  }) : super(key: key);

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
            const Text(
              'Error ao apagar Evento',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ).withPaddingOnly(bottom: 16),
            const Expanded(
              child: Text(
                'Não conseguimos apagar seu evento, mas por favor volte a tentar mais tarde',
                style: TextStyle(
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
          onPressed: Navigator.of(context).pop,
          customBackgroundColor: Theme.of(context).primaryColor,
        ).withPaddingOnly(bottom: 36),
      ),
    );
  }
}
