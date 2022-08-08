import 'package:cfit/view/common/button.dart';
import 'package:cfit/view/common/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_cubit.dart';
import 'register_state.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailFormKey = GlobalKey<FormState>();
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
      body: Padding(
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
              presentShowError(context);
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
                    hintText: 'Nome e Sobrenome',
                    onChanged: cubit.onChangeEmail,
                    type: InputTextType.email,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: DropdownButton<String>(
                    items: Gender.values
                        .map(
                          (gender) => DropdownMenuItem(
                            value: gender.toStringRepresentation(),
                            child: Text(
                              gender.toStringRepresentation(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {},
                    elevation: 0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: InputText(
                    hintText: 'Email',
                    onChanged: cubit.onChangeEmail,
                    type: InputTextType.email,
                    formKey: emailFormKey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: InputText(
                    hintText: 'Senha',
                    onChanged: cubit.onChangePassword,
                    type: InputTextType.password,
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: ButtonAction(
                      text: 'Esqueceu sua senha ?',
                      type: ButtonActionType.text,
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      return ButtonAction(
                        text: 'Entrar',
                        type: ButtonActionType.primary,
                        onPressed: state.isEnabled
                            ? () {
                                if (emailFormKey.currentState!.validate()) {
                                  cubit.authentication();
                                }
                              }
                            : null,
                        loading: state.loadingRequest,
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: ButtonAction(
                    text: 'Cadastre-se',
                    type: ButtonActionType.text,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void presentShowError(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      constraints: BoxConstraints.loose(
        Size(
          double.infinity,
          MediaQuery.of(context).size.height * 0.35,
        ),
      ),
      builder: (context) => const RegisterErrorModal(),
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
