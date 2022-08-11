import 'package:cfit/domain/models/user.dart';
import 'package:cfit/util/extentions.dart';
import 'package:cfit/view/common/button.dart';
import 'package:cfit/view/common/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'register_cubit.dart';
import 'register_state.dart';

final dateBirthMask = MaskTextInputFormatter(
  mask: '##/##/####',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameFormKey = GlobalKey<FormState>();
    final dateBirthFormKey = GlobalKey<FormState>();
    final emailFormKey = GlobalKey<FormState>();
    final passwordFormKey = GlobalKey<FormState>();
    final confirmedPasswordFormKey = GlobalKey<FormState>();

    final cubit = context.read<RegisterCubit>();
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
        title: Column(
          children: const [
            Text(
              'Cadastre-se',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Crie sua conta agora !',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 16,
              ),
              child: BlocConsumer<RegisterCubit, RegisterState>(
                buildWhen: (previous, current) =>
                    previous.hasError != current.hasError,
                listenWhen: (previous, current) =>
                    previous.hasError != current.hasError,
                listener: (context, state) {
                  if (state.hasError) {
                    presentShowError(
                      context,
                      accountExists: state.accountExists,
                      onPressed: cubit.goToLogin,
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: InputText(
                          formKey: nameFormKey,
                          hintText: 'Nome e Sobrenome',
                          onChanged: cubit.onChangeName,
                          type: InputTextType.text,
                          validator: (name) {
                            if (name?.contains(RegExp(r'[0-9]')) == true) {
                              return 'Não pode haver números no seu nome';
                            }
                            if (name?.contains(RegExp(r' ')) == false) {
                              return 'Por favor insira seu sobrenome';
                            }
                            return null;
                          },
                        ),
                      ),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
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
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: InputText(
                          hintText: 'Email',
                          formKey: emailFormKey,
                          onChanged: cubit.onChangeEmail,
                          type: InputTextType.email,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: InputText(
                          hintText: 'Senha',
                          formKey: passwordFormKey,
                          onChanged: cubit.onChangePassword,
                          type: InputTextType.password,
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return 'Por favor, preencha uma senha';
                            }
                            if (password.length < 5) {
                              return 'Insira um senha com mais de 4 caracteres';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: InputText(
                          hintText: 'Confirme sua senha',
                          formKey: confirmedPasswordFormKey,
                          onChanged: cubit.onChangeConfirmedPassword,
                          type: InputTextType.password,
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return 'Por favor, preencha a confirmação senha';
                            }
                            if (password != cubit.state.password) {
                              return 'Repita a senha que você inseriu a cima';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: BlocBuilder<RegisterCubit, RegisterState>(
                          builder: (context, state) {
                            return ButtonAction(
                              text: 'Cadastra-se',
                              type: ButtonActionType.primary,
                              onPressed: state.isEnabled
                                  ? () {
                                      if (nameFormKey.currentState!
                                              .validate() ||
                                          dateBirthFormKey.currentState!
                                              .validate() ||
                                          emailFormKey.currentState!
                                              .validate() ||
                                          passwordFormKey.currentState!
                                              .validate() ||
                                          confirmedPasswordFormKey.currentState!
                                              .validate()) {
                                        cubit.register();
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
                          onPressed: cubit.goToLogin,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Image.asset(
              'assets/images/2460797-ai.png',
              fit: BoxFit.fill,
            )
          ],
        ),
      ),
    );
  }

  void presentShowError(
    BuildContext context, {
    required bool accountExists,
    VoidCallback? onPressed,
  }) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      constraints: BoxConstraints.loose(
        Size(
          double.infinity,
          MediaQuery.of(context).size.height * 0.45,
        ),
      ),
      builder: (context) => accountExists
          ? RegisterErrorAlreadyExistsModal(onPressed: onPressed!)
          : const RegisterErrorModal(),
      elevation: 5,
    );
  }
}

class RegisterErrorModal extends StatelessWidget {
  const RegisterErrorModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.close,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Falha no Register',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '''Aconteceu algum problema com as informações inseridas. Por favor verifique os valores inseridos, e tente novamente.''',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        )
      ],
    );
  }
}

class RegisterErrorAlreadyExistsModal extends StatelessWidget {
  const RegisterErrorAlreadyExistsModal({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.close,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Parece que esse email já existe',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '''Esse email já está cadastrado nos nossos sistemas. Tente usar o outro email, para realizar o cadastro, ou tente fazer o login usando esse email pressionando o botão abaixo''',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ButtonAction(
            text: 'Entrar',
            type: ButtonActionType.primary,
            onPressed: () {
              Navigator.of(context).pop();
              onPressed();
            },
          ),
        )
      ],
    );
  }
}
