import 'package:cfit/util/bottom_sheet.dart';
import 'package:cfit/view/common/button.dart';
import 'package:cfit/view/common/input_text.dart';
import 'package:cfit/view/common/modais.dart';
import 'package:cfit/view/common/padding.dart';
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
                      onPressed: () {
                        Navigator.pop(context);
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
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ButtonAction(
                            text: 'Esqueceu sua senha ?',
                            type: ButtonActionType.text,
                            onPressed: cubit.recoverPassword,
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
              'Falha no login',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ).withPaddingOnly(bottom: 16),
            const Expanded(
              child: Text(
                '''Aconteceu algum problema com as informações inseridas. Por favor verifique os valores inseridos, e tente novamente.''',
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
