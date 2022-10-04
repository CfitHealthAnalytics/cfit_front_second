import 'package:cfit/domain/models/user.dart';
import 'package:cfit/util/bottom_sheet.dart';
import 'package:cfit/util/extentions.dart';
import 'package:cfit/view/common/button.dart';
import 'package:cfit/view/common/input_text.dart';
import 'package:cfit/view/common/modais.dart';
import 'package:cfit/view/common/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'complete_account_cubit.dart';
import 'complete_account_state.dart';

final dateBirthMask = MaskTextInputFormatter(
  mask: '##/##/####',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

class CompleteAccountScreen extends StatelessWidget {
  const CompleteAccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateBirthFormKey = GlobalKey<FormState>();
    final cubit = context.read<CompleteAccountCubit>();
    return BlocConsumer<CompleteAccountCubit, CompleteAccountState>(
      buildWhen: (previous, current) => previous.hasError != current.hasError,
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == Status.notFound) {
          presentBottomSheet(
            context: context,
            modal: LoginNotFoundErrorModal(
              onPressed: () {
                Navigator.pop(context);
                cubit.completeAccount();
              },
            ),
          );
        }
        if (state.status == Status.fail) {
          presentBottomSheet(
            context: context,
            modal: LoginErrorModal(
              onPressed: () {
                Navigator.pop(context);
                cubit.completeAccount();
              },
            ),
          );
        }

        if (state.status == Status.success) {
          presentBottomSheet(
            context: context,
            modal: LoginSuccessModal(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 6.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 16,
                  ),
                ),
              ),
              onPressed: cubit.onBack,
            ),
            title: const Text(
              'Precisamos de algumas' '\ninformações',
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Para continuarmos preencha com as informações restantes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ).withPaddingOnly(
                  bottom: 16,
                  left: 40,
                  right: 40,
                  top: 40,
                ),
                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: DropdownButtonFormField<String>(
                    items: UserGender.values
                        .map(
                          (gender) => DropdownMenuItem(
                            value: gender.toStringRepresentation(),
                            child: Text(
                              gender
                                  .toStringRepresentation()
                                  .upperOnlyFirstLetter(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: cubit.onChangeGender,
                    elevation: 0,
                    value: UserGender.male.toStringRepresentation(),
                    decoration: const InputDecoration(
                      hintText: "Gênero",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: InputText(
                    hintText: 'Data de Nascimento',
                    onChanged: cubit.onChangeDateBirth,
                    type: InputTextType.text,
                    formKey: dateBirthFormKey,
                    inputFormatter: [dateBirthMask],
                    validator: (dateBirth) =>
                        (dateBirth == null || dateBirth.length != 10)
                            ? 'Insira uma data de nascimento válida'
                            : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ButtonAction(
                    text: 'Finalizar',
                    type: ButtonActionType.primary,
                    onPressed: cubit.completeAccount,
                  ),
                ),
              ],
            ).withPaddingSymmetric(horizontal: 24),
          ),
        );
      },
    );
  }
}

class LoginErrorModal extends Modal {
  const LoginErrorModal({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final VoidCallback onPressed;

  @override
  double get fraction => 0.5;

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
              'Falha ao Recuperar senha',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ).withPaddingOnly(bottom: 16),
            const Expanded(
              child: Text(
                '''Aconteceu algum problema com os nossos sistemas. tente novamente mais tarde.''',
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
          text: 'Tentar novamente',
          type: ButtonActionType.primary,
          onPressed: onPressed,
          customBackgroundColor: Theme.of(context).primaryColor,
        ).withPaddingOnly(bottom: 36),
      ),
    );
  }
}

class LoginNotFoundErrorModal extends Modal {
  const LoginNotFoundErrorModal({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final VoidCallback onPressed;

  @override
  double get fraction => 0.5;

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
              'Email não cadastrado',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ).withPaddingOnly(bottom: 16),
            const Expanded(
              child: Text(
                '''Esse Email não está cadastrado nos nossos sistemas. Você pode tentar criar uma conta usando esse email, e usar nossos serviços facilmente.''',
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
          text: 'Cadastrar',
          type: ButtonActionType.primary,
          onPressed: onPressed,
          customBackgroundColor: Theme.of(context).primaryColor,
        ).withPaddingOnly(bottom: 36),
      ),
    );
  }
}

class LoginSuccessModal extends Modal {
  const LoginSuccessModal({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final VoidCallback onPressed;

  @override
  double get fraction => 0.5;

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
              'Email enviado',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ).withPaddingOnly(bottom: 16),
            const Expanded(
              child: Text(
                '''Enviamos um email para recuperação da sua senha. As vezes o email pode levar alguns minutinhos para chegar, então não se preocupe se ele não chegar imediatamente. Lembre-se de checar se ele não caiu na caixa de SPAM.''',
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
          onPressed: onPressed,
          customBackgroundColor: Theme.of(context).primaryColor,
        ).withPaddingOnly(bottom: 36),
      ),
    );
  }
}
