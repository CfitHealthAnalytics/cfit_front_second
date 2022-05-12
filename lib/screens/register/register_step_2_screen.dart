import 'dart:async';
import 'package:cfit/components/custom_button.dart';
import 'package:cfit/screens/login/login_screen.dart';
import 'package:cfit/screens/welcome/welcome_screen.dart';
import 'package:cfit/constants.dart';
import 'package:cfit/util/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';

import 'package:mask_input_formatter/mask_input_formatter.dart';

import 'package:cfit/components/inputs_button.dart';

class RegisterStep2Screen extends StatelessWidget {
  const RegisterStep2Screen({Key? key}) : super(key: key);

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
            height: 120,
            margin: EdgeInsets.only(bottom: 32),
            padding: EdgeInsets.only(top: 32, bottom: 10),
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
            ),
            child: Image.asset(Images.logo_name, width: 100,
              fit: BoxFit.contain,),
          ),
          SizedBox(height: kDefaultPadding),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Complete seus dados',
                    style: TextStyle(
                        fontSize: 28,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center),
                SizedBox(height: kDefaultPadding),
                Text(
                  'Data de Nascimento',
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
                        mask: '##/##/####', textAllCaps: true)
                  ],
                  decoration: InputDecoration(
                      fillColor: kInputColor,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                    hintText: "00/00/0000",
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                ),

                SizedBox(height: kDefaultPadding / 3),


                Text(
                  'Gênero Biológico',
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

                SizedBox(height: kDefaultPadding/3),

                Text(
                  'Altura',
                  style: TextStyle(
                      fontSize: 16,
                      color: kINputLabelColor,
                      fontWeight: FontWeight.w600),
                ),
                TextFormField(
                  style: TextStyle(
                      color: kInputTextColor, fontWeight: FontWeight.w600),
                  // another example with text and numbers
                  inputFormatters: [
                    MaskInputFormatter(
                        mask: '######.##', textAllCaps: true)
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

                SizedBox(height: 40),

                Text('Deseja atingir uma meta?',
                    style: TextStyle(
                        fontSize: 28,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center),
                SizedBox(height: kDefaultPadding),

                Text(
                  'Meta Peso (kg)',
                  style: TextStyle(
                      fontSize: 16,
                      color: kINputLabelColor,
                      fontWeight: FontWeight.w600),
                ),
                TextFormField(
                  style: TextStyle(
                      color: kInputTextColor, fontWeight: FontWeight.w600),
                  // another example with text and numbers
                  inputFormatters: [
                    MaskInputFormatter(
                        mask: '######', textAllCaps: true)
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

                SizedBox(height: kDefaultPadding / 2),

                Text(
                  'Meta Fordura Corporal (%)',
                  style: TextStyle(
                      fontSize: 16,
                      color: kINputLabelColor,
                      fontWeight: FontWeight.w600),
                ),
                TextFormField(
                  style: TextStyle(
                      color: kInputTextColor, fontWeight: FontWeight.w600),
                  // another example with text and numbers
                  inputFormatters: [
                    MaskInputFormatter(
                        mask: '##', textAllCaps: true)
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

                SizedBox(height: kDefaultPadding / 2),
                CustomButton(
                    tap: () {
                      showTopSnackBar(
                        context,
                        CustomSnackBar.success(
                          message: "Conta criada com sucesso.",
                        ),
                      );

                    },
                    text: 'Finalizar Cadastro'),
                SizedBox(height: 49),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
