import 'package:cfit/infrastructure/navigation/routes.dart';
import 'package:cfit/presentation/shared/loading/base.widget.dart';
import 'package:cfit/util/dimensions.dart';
import 'package:cfit/view/ui/screens/register/controllers/register.controller.dart';
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

  @override
  void dispose() {
    super.dispose();
  }

  Widget _datePicker() {
    return TextField(
      controller: _dateController,
      readOnly: true,
      style: const TextStyle(
        color: kBackgroundBlack,
      ),
      decoration: const InputDecoration(
        fillColor: Colors.white,
        filled: true,
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

  String dropdownValue = 'Masculino';

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0),
              child: Container(
                width: context.width > 700 ? 700 : context.width,
                /*padding: context.width > 700
                      ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
                      : null,*/

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
                child: GetBuilder<RegisterController>(
                    builder: (registerController) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 50),
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top,
                            right: 25,
                            left: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Get.toNamed(Routes.login),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Center(
                              child: Text(
                                'Cadastre-se',
                                style: TextStyle(
                                    fontSize: 32,
                                    color: kBackgroundWhite,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Email TextField
                            TextField(
                              onChanged: registerController.nome,
                              textAlign: TextAlign.left,
                              focusNode: registerController.nomeFocus,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(
                                color: kBackgroundBlack,
                              ),
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                hintText: "Nome Completo",
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),

                            /// Email TextField
                            TextField(
                              onChanged: registerController.email,
                              textAlign: TextAlign.left,
                              focusNode: registerController.emailFocus,
                              style: const TextStyle(
                                color: kBackgroundBlack,
                              ),
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                hintText: 'E-mail',
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),

                            TextField(
                              controller: _dateController,
                              readOnly: true,
                              style: const TextStyle(
                                color: kBackgroundBlack,
                              ),
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "Data de Nascimento",
                              ),
                              onTap: () async {
                                // open the date picker

                                final selectedDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1930),
                                  lastDate: DateTime(2100),
                                  initialDate: DateTime.now(),
                                  selectableDayPredicate: (day) =>
                                      day.isBefore(DateTime.now()),
                                );
                                if (selectedDate != null) {
                                  setState(() {
                                    _dateController.text =
                                        DateFormat('dd/MM/yyyy')
                                            .format(selectedDate);
                                    registerController.datec.value =
                                        DateFormat('dd/MM/yyyy')
                                            .format(selectedDate);
                                  });
                                }
                              },
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            Row(
                              children: [
                                Container(
                                  width: 150,
                                  //width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),

                                  // dropdown below..
                                  child: DropdownButton<String>(
                                    value: dropdownValue,
                                    icon: const Icon(Icons.arrow_downward),
                                    elevation: 16,
                                    //style: const TextStyle(color: Colors.deepPurple),

                                    style: const TextStyle(
                                      color: kBackgroundBlack,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    underline: Container(
                                      height: 0,
                                      color: kPrimaryColor,
                                    ),

                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                        registerController.genero.value =
                                            dropdownValue;
                                      });
                                    },
                                    items: <String>[
                                      'Masculino',
                                      'Feminino',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            /// Password TextField
                            TextField(
                              obscureText: true,
                              onChanged: registerController.password,
                              textAlign: TextAlign.left,
                              focusNode: registerController.passwordFocus,
                              style: const TextStyle(
                                color: kBackgroundBlack,
                              ),
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                hintText: 'Senha',
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),

                            /// Confrim Password TextField
                            TextField(
                              obscureText: true,
                              onChanged: registerController.cpassword,
                              textAlign: TextAlign.left,
                              focusNode: registerController.cpasswordFocus,
                              style: const TextStyle(
                                color: kBackgroundBlack,
                              ),
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                hintText: 'Confirme sua senha',
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            ElevatedButton(
                              onPressed: () {
                                registerController.doRegister();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(kPrimaryBottom),
                              ),
                              child: const SizedBox(
                                height: 60,
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    'Cadastre-se',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            /// LOGIN TEXT
                            GestureDetector(
                              onTap: () => {Get.toNamed(Routes.login)},
                              child: const Center(
                                child: Text(
                                  'Entrar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 5,
                            ),

                            Image.asset(
                              'assets/images/2460797-ai.png',
                              scale: 1,
                              width: context.width,
                            ),
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
      ),
    );
  }

  /*

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
                  child: GetBuilder<RegisterController>(builder: (registerController) {
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
                                      _singUp(registerController);
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
    */
}
