import 'package:cfit/util/bottom_sheet.dart';
import 'package:cfit/view/common/button.dart';
import 'package:cfit/view/common/input_text.dart';
import 'package:cfit/view/ui/screens/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailFormKey = GlobalKey<FormState>();
    final cubit = context.read<LoginCubit>();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: BlocConsumer<LoginCubit, LoginState>(
            buildWhen: (previous, current) =>
                previous.hasError != current.hasError,
            listenWhen: (previous, current) =>
                previous.hasError != current.hasError,
            listener: (context, state) {
              if (state.hasError) {
                presentBottomSheet(
                  context: context,
                  builder: (_) => const LoginErrorModal(),
                );
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/vamoo_white.png',
                    height: 200,
                  ),
                  const SizedBox(height: 32),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'Entrar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
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
                    child: BlocBuilder<LoginCubit, LoginState>(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ButtonAction(
                      text: 'Cadastre-se',
                      type: ButtonActionType.text,
                      onPressed: cubit.register,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class LoginErrorModal extends StatelessWidget {
  const LoginErrorModal({
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
            'Falha no login',
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
