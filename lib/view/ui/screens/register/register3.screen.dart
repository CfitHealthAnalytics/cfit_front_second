import 'package:cfit/controller/auth_controller.dart';
import 'package:cfit/data/modal/body/signup_body.dart';
import 'package:cfit/domain/core/utils/snackbar.util.dart';
import 'package:cfit/infrastructure/navigation/routes.dart';
import 'package:cfit/util/Images.dart';
import 'package:cfit/util/dimensions.dart';
import 'package:cfit/view/base/animation/fadeanimation.dart';
import 'package:cfit/view/base/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:cfit/constants.dart';

class RegisterScreen extends StatefulWidget {
  final bool exitFromApp;
  const RegisterScreen({required this.exitFromApp});

  @override
  State<RegisterScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<RegisterScreen> {
  /// TextFields Controller
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _dateController = TextEditingController();

  /// Password =! ConfirmPassword
  var aSnackBar = const SnackBar(
    content: Text('A senha não corresponde à senha de confirmação'),
  );

  /// Password & ConfirmPassword is Empty
  var bSnackBar = const SnackBar(
    content: Text('Os campos Senha e Confirmar Senha devem ser preenchidos!'),
  );

  /// Confirm Password is Empty
  var cSnackBar = const SnackBar(
    content: Text('O campo Confirmar Senha deve ser preenchido!'),
  );

  /// Confirm Password is Empty
  var dNSnackBar = const SnackBar(
    content: Text('Preencha a sua data de nascimento!'),
  );

  /// Password is Empty
  var dSnackBar = const SnackBar(
    content: Text('O campo Senha deve ser preenchido!'),
  );

  /// Password is Empty
  var dCSnackBar = const SnackBar(
    content: Text('A Senha e a confirmação precisam ser a mesma.'),
  );

  /// Email Empty & Password Fill
  var smSnackBar = const SnackBar(
    content: Text('A senha deve ter mais de 6 caracteres'),
  );

  /// Email & Confirm Password is Empty
  var eSnackBar = const SnackBar(
    content: Text('Os campos Email e Confirmar Senha devem ser preenchidos!'),
  );

  /// Email is Empty
  var fSnackBar = const SnackBar(
    content: Text('O campo E-mail deve ser preenchido!'),
  );

  /// Email & password is Empty
  var gSnackBar = const SnackBar(
    content: Text('Os campos Email e Senha devem ser preenchidos!'),
  );

  /// All Fields Empty
  var xSnackBar = const SnackBar(
    content: Text('Você deve preencher todos os campos'),
  );

  /// SIGNING UP METHOD TO FIREBASE
  Future signUp() async {}

  /// CHECK IF PASSWORD CONFIREMD OR NOT
  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _datePicker() {
    return TextField(
      controller: _dateController,
      readOnly: true,
      decoration: const InputDecoration(
        labelText: "Data de Nascimento",
        hintText: "Data de Nascimento",
      ),
      onTap: () async {
        // open the date picker

        final selectedDate = await showDatePicker(
          context: context,
          firstDate: DateTime(1930),
          lastDate: DateTime(2100),
          initialDate: DateTime.now(),
          selectableDayPredicate: (day) => day.isBefore(DateTime.now()),
        );
        if (selectedDate != null) {
          setState(() {
            _dateController.text =
                DateFormat('dd/MM/yyyy').format(selectedDate);
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.exitFromApp) {
          if (GetPlatform.isAndroid) {
            //SystemNavigator.pop();
          } else if (GetPlatform.isIOS) {
            //exit(0);
          } else {
            //Navigator.pushNamed(context, RouteHelper.getInitialRoute());
          }
          return Future.value(false);
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: SafeArea(
            child: Center(
          child: Scrollbar(
            child: SingleChildScrollView(
              //physics: BouncingScrollPhysics(),
              //padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Center(
                child: Container(
                  width: context.width > 700 ? 700 : context.width,
                  decoration: context.width > 700
                      ? BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          boxShadow: const [
                            BoxShadow(blurRadius: 5, spreadRadius: 1)
                          ],
                        )
                      : null,
                  child: GetBuilder<AuthController>(builder: (authController) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          height: 240,
                          margin: const EdgeInsets.only(bottom: 32),
                          padding: const EdgeInsets.only(top: 32),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Theme.of(context).primaryColorLight,
                                    Theme.of(context).primaryColorDark
                                  ]),
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(0, 0),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    color: Colors.black)
                              ],
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(80))),
                          //child: Image.asset(Images.logo_nameLogin, width: 100),
                          child: const OverflowBox(
                            minWidth: 0.0,
                            minHeight: 0.0,
                            maxHeight: 90,
                            child: Image(
                                image: AssetImage(Images.logo_nameLogin),
                                fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(height: kDefaultPadding),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeAnimation(
                                delay: 1.5,
                                child: const Text('Criar uma conta',
                                    style: TextStyle(
                                        fontSize: 32,
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center),
                              ),
                              const SizedBox(height: kDefaultPadding / 3),

                              const SizedBox(
                                height: 50,
                              ),

                              /// Email TextField
                              FadeAnimation(
                                delay: 2.0,
                                child: TextField(
                                  controller: _nomeController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Nome Completo",
                                    hintText: 'Nome Completo',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),

                              /// Email TextField
                              FadeAnimation(
                                delay: 2.0,
                                child: TextField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'E-mail',
                                    hintText: 'E-mail',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),

                              FadeAnimation(
                                delay: 2.1,
                                child: _datePicker(),
                              ),

                              const SizedBox(
                                height: 15,
                              ),

                              /// Password TextField
                              FadeAnimation(
                                delay: 2.5,
                                child: TextField(
                                  obscureText: true,
                                  controller: _passwordController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Senha',
                                    hintText: 'Senha',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),

                              /// Confrim Password TextField
                              FadeAnimation(
                                delay: 3,
                                child: TextField(
                                  obscureText: true,
                                  controller: _confirmPasswordController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Confirme sua senha',
                                    hintText: 'Confirme sua senha',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              /// SIGN UP BUTTON
                              FadeAnimation(
                                delay: 3.5,
                                child: CustomButton(
                                    tap: () {
                                      _singUp(authController);
                                    },
                                    text: 'Criar Conta'),
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              /// LOGIN TEXT
                              GestureDetector(
                                onTap: () => {Get.toNamed(Routes.login)},
                                child: FadeAnimation(
                                  delay: 4,
                                  child: RichText(
                                    text: TextSpan(
                                        text: "já tem uma conta?",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: " Realizar Login",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          )
                                        ]),
                                  ),
                                ),
                              ),
                              const SizedBox(height: kDefaultPadding / 2),
                            ],
                          ),
                        )
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }

  void _singUp(AuthController authController) async {
    bool _isValid = GetPlatform.isWeb ? true : false;
    if (!GetPlatform.isWeb) {
      try {
        //PhoneNumber phoneNumber = await PhoneNumberUtil().parse(_numberWithCountryCode);
        //_numberWithCountryCode = '+' + phoneNumber.countryCode + phoneNumber.nationalNumber;
        _isValid = true;
      } catch (e) {}
    }

    if (_emailController.text.isNotEmpty &
        _passwordController.text.isEmpty &
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(bSnackBar);
    }

    ///
    else if (_emailController.text.isNotEmpty &
        _passwordController.text.isNotEmpty &
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(cSnackBar);
    }

    ///
    else if (_emailController.text.isNotEmpty &
        _passwordController.text.isNotEmpty &
        _confirmPasswordController.text.isNotEmpty &
        _dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(dNSnackBar);
    }

    ///
    else if (_emailController.text.isNotEmpty &
        _passwordController.text.isEmpty &
        _confirmPasswordController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(dSnackBar);
    }

    ///
    else if (_emailController.text.isEmpty &
        _passwordController.text.isNotEmpty &
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(eSnackBar);
    }

    ///
    else if (_emailController.text.isEmpty &
        _passwordController.text.isNotEmpty &
        _confirmPasswordController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(fSnackBar);
    }

    ///
    else if (_emailController.text.isEmpty &
        _passwordController.text.isEmpty &
        _confirmPasswordController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(gSnackBar);
    } else if (_passwordController.text.trim() !=
        _confirmPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(dCSnackBar);
    } else if (_passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(smSnackBar);
    } else if (_nomeController.text.isNotEmpty &
        _emailController.text.isNotEmpty &
        _passwordController.text.isNotEmpty &
        _confirmPasswordController.text.isNotEmpty &
        _dateController.text.isNotEmpty) {
      if (passwordConfirmed()) {
        SignUpBody signUpBody = SignUpBody(
            nome: _nomeController.text.trim(),
            email: _emailController.text.trim(),
            data_nascimento: _dateController.text.trim(),
            password: _passwordController.text.trim(),
            genero: 'Masculino');

        authController.registration(signUpBody).then((status) async {
          if (status.isSuccess) {
            authController.saveUserNumberAndPassword(
                _emailController.text.trim(),
                _passwordController.text.trim(),
                'br');

            SnackbarUtil.showSuccess(
                message: 'Sua conta foi criada com sucesso.');
            Get.toNamed(Routes.login);
          } else {
            if (status.message == 'EMAIL_EXISTS') {
              SnackbarUtil.showWarning(message: 'E-mail informado já existe.');
            } else {
              SnackbarUtil.showWarning(message: status.message);
              /*
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(status.message),
              ));*/
            }
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(aSnackBar);
      }

      /// In the below, with if statement we have some simple validate
    }

    ///
    else {
      ScaffoldMessenger.of(context).showSnackBar(xSnackBar);
    }
  }
}
