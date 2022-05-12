import 'dart:async';
import 'package:cfit/components/custom_button.dart';
import 'package:cfit/components/social_button.dart';
import 'package:cfit/screens/login/login_screen.dart';
import 'package:cfit/screens/register/register_step_2_screen.dart';
import 'package:cfit/screens/welcome/welcome_screen.dart';
import 'package:cfit/constants.dart';
import 'package:cfit/responsive.dart';
import 'package:cfit/util/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';

import 'package:mask_input_formatter/mask_input_formatter.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                Widget>[
          Container(
            height: 240,
            margin: EdgeInsets.only(bottom: 32),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Theme.of(context).primaryColorLight,
                      Theme.of(context).primaryColorDark
                    ]),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                      blurRadius: 4,
                      color: Colors.black)
                ],
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(80))),
            child: Image.asset(Images.logo_nameLogin, width: 100,
              fit: BoxFit.contain,),
          ),
          SizedBox(height: kDefaultPadding),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cadastre-se',
                    style: TextStyle(
                        fontSize: 32,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center),
                SizedBox(height: kDefaultPadding / 3),
                Text(
                  'Nome',
                  style: TextStyle(
                      fontSize: 16,
                      color: kINputLabelColor,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: kDefaultPadding / 3),
                TextField(
                  style: TextStyle(
                      color: kInputTextColor, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                      fillColor: kInputColor,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                      prefix: Padding(
                        padding: EdgeInsets.only(right: kDefaultPadding / 4),
                        child: Text(
                          '',
                          style: TextStyle(
                              color: kInputTextColor,
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                ),
                SizedBox(height: kDefaultPadding / 3),
                Text(
                  'CPF',
                  style: TextStyle(
                      fontSize: 16,
                      color: kINputLabelColor,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: kDefaultPadding / 3),

                TextFormField(
                  style: TextStyle(
                      color: kInputTextColor, fontWeight: FontWeight.w600),
                  // another example with text and numbers
                  inputFormatters: [
                    MaskInputFormatter(
                        mask: '###.###.###-##', textAllCaps: true)
                  ],
                  decoration: InputDecoration(
                    fillColor: kInputColor,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                    hintText: "",
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                ),

                SizedBox(height: kDefaultPadding / 3),
                Text(
                  'E-mail',
                  style: TextStyle(
                      fontSize: 16,
                      color: kINputLabelColor,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: kDefaultPadding / 3),

                TextField(
                  style: TextStyle(
                      color: kInputTextColor, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                      fillColor: kInputColor,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                      prefix: Padding(
                        padding: EdgeInsets.only(right: kDefaultPadding / 4),
                        child: Text(
                          '',
                          style: TextStyle(
                              color: kInputTextColor,
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                ),
                SizedBox(height: kDefaultPadding / 3),
                Text(
                  'Telefone',
                  style: TextStyle(
                      fontSize: 16,
                      color: kINputLabelColor,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: kDefaultPadding / 3),

                TextFormField(
                  style: TextStyle(
                      color: kInputTextColor, fontWeight: FontWeight.w600),
                  // another example with text and numbers
                  inputFormatters: [
                    MaskInputFormatter(
                        mask: '(##) #.####-####', textAllCaps: true)
                  ],
                  decoration: InputDecoration(
                    fillColor: kInputColor,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                    hintText: "",
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: kDefaultPadding / 3),
                Text(
                  'Senha',
                  style: TextStyle(
                      fontSize: 16,
                      color: kINputLabelColor,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: kDefaultPadding / 3),
                TextField(
                  style: TextStyle(
                      color: kInputTextColor, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                      fillColor: kInputColor,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                      prefix: Padding(
                        padding: EdgeInsets.only(right: kDefaultPadding / 4),
                        child: Text(
                          '',
                          style: TextStyle(
                              color: kInputTextColor,
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                ),
                SizedBox(height: kDefaultPadding / 3),
                Text(
                  'Confirme sua senha',
                  style: TextStyle(
                      fontSize: 16,
                      color: kINputLabelColor,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: kDefaultPadding / 3),
                TextField(
                  style: TextStyle(
                      color: kInputTextColor, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                      fillColor: kInputColor,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                      prefix: Padding(
                        padding: EdgeInsets.only(right: kDefaultPadding / 4),
                        child: Text(
                          '',
                          style: TextStyle(
                              color: kInputTextColor,
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                ),
                SizedBox(height: kDefaultPadding / 2),
                CustomButton(
                    tap: () {
                      showTopSnackBar(
                        context,
                        CustomSnackBar.success(
                          message: "Conta criada com sucesso.",
                        ),
                      );
                      var timer = Timer(Duration(seconds: 1), () =>
                      {

                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterStep2Screen()),
                        )

                      }

                      );

                    },
                    text: 'Criar Conta'),
                SizedBox(height: kDefaultPadding / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: kAltDarkTextColor,
                      width: size.width / 8,
                      height: 1,
                    ),
                    SizedBox(width: kDefaultPadding / 3),
                    Text('or',
                        style: TextStyle(
                            color: kAltDarkTextColor,
                            fontWeight: FontWeight.w600)),
                    SizedBox(width: kDefaultPadding / 3),
                    Container(
                      color: kAltDarkTextColor,
                      width: size.width / 8,
                      height: 1,
                    ),
                  ],
                ),
                SizedBox(height: kDefaultPadding / 2),
                CustomButton(
                    tap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    text: 'Já tenho uma Conta'),
                /*SizedBox(height: kDefaultPadding / 2),
                Row(children: [
                  Expanded(
                    child: SocialButton(
                      tap: () {
                        showTopSnackBar(
                          context,
                          CustomSnackBar.success(
                            message: "Login Realizado pelo Google",
                          ),
                        );
                      },
                      icon: 'assets/icons/google.svg',
                      color: kGoogleColor,
                    ),
                  ),
                  SizedBox(width: kDefaultPadding / 2),
                  Expanded(
                    child: SocialButton(
                      tap: () {
                        showTopSnackBar(
                          context,
                          CustomSnackBar.success(
                            message: "Login Realizado pelo Facebook",
                          ),
                        );
                      },
                      icon: 'assets/icons/fb.svg',
                      color: kFbColor,
                    ),
                  ),
                ]),
                */
                SizedBox(height: kDefaultPadding / 2),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(color: kAltTextColor),
                      children: [
                        TextSpan(
                            text:
                                "Ao continuar a fazer o login, você aceita a nossa empresa "),
                        TextSpan(
                          text: 'Termo e condições',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kAltDarkTextColor,
                              decoration: TextDecoration.underline),
                        ),
                        TextSpan(text: ' e '),
                        TextSpan(
                          text: 'Políticas de privacidade.',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kAltDarkTextColor,
                              decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: kDefaultPadding / 2),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
