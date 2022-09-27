import 'package:cfit/util/bottom_sheet.dart';
import 'package:cfit/view/common/button.dart';
import 'package:cfit/view/common/input_text.dart';
import 'package:cfit/view/common/modais.dart';
import 'package:cfit/view/common/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'recover_password_cubit.dart';
import 'recover_password_state.dart';

class RecoverPasswordScreen extends StatelessWidget {
  const RecoverPasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailFormKey = GlobalKey<FormState>();
    final confirmFormKey = GlobalKey<FormState>();
    final cubit = context.read<RecoverPasswordCubit>();
    return SingleChildScrollView(
      child: BlocConsumer<RecoverPasswordCubit, RecoverPasswordState>(
        buildWhen: (previous, current) => previous.hasError != current.hasError,
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == Status.notFound) {
            presentBottomSheet(
              context: context,
              modal: LoginNotFoundErrorModal(
                onPressed: () {
                  Navigator.pop(context);
                  cubit.register();
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
                  cubit.recoverPassword();
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
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.zero,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/background_recover_password.png',
                        ),
                        fit: BoxFit.fill),
                  ),
                ),
                Scaffold(
                  backgroundColor: Colors.transparent,
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
                      'Problemas para entrar?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Preencha seu e-mail para recuperar sua senha',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ).withPaddingOnly(bottom: 16),
                      const SizedBox(height: 60),
                      InputText(
                        hintText: 'Email',
                        onChanged: cubit.onChangeEmail,
                        type: InputTextType.email,
                        formKey: emailFormKey,
                      ).withPaddingOnly(bottom: 16),
                      InputText(
                        hintText: 'Confirme seu E-mail',
                        onChanged: cubit.onChangeConfirmEmail,
                        type: InputTextType.email,
                        formKey: confirmFormKey,
                      ).withPaddingOnly(bottom: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: BlocBuilder<RecoverPasswordCubit,
                            RecoverPasswordState>(
                          builder: (context, state) {
                            return ButtonAction(
                              text: 'Recuperar Senha',
                              type: ButtonActionType.primary,
                              onPressed: state.isEnabled
                                  ? () {
                                      if (emailFormKey.currentState!
                                              .validate() &&
                                          confirmFormKey.currentState!
                                              .validate()) {
                                        cubit.recoverPassword();
                                      }
                                    }
                                  : null,
                              loading: state.loadingRequest,
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: ButtonAction(
                          text: 'Entrar',
                          type: ButtonActionType.text,
                          onPressed: cubit.onBack,
                        ),
                      ),
                    ],
                  ).withPaddingSymmetric(horizontal: 24),
                ),
              ],
            ),
          );
        },
      ),
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
