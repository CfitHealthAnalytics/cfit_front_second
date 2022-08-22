import 'package:cfit/util/bottom_sheet.dart';
import 'package:cfit/view/common/button.dart';
import 'package:cfit/view/common/input_text.dart';
import 'package:cfit/view/common/modais.dart';
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
      body: Center(
        child: Padding(
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
                    modal: LoginErrorModal(
                      context: context,
                      onPressed: () {
                        Navigator.of(context).pop();
                        cubit.authentication();
                      },
                    ),
                  );
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
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
                                      if (emailFormKey.currentState!
                                          .validate()) {
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
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class LoginErrorModal implements Modal {
  LoginErrorModal({
    required this.onPressed,
    required this.context,
  });

  final VoidCallback onPressed;
  final BuildContext context;

  @override
  double get fraction => 0.5;

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
        'Falha no login',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      );
}
