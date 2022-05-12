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

import 'package:cfit/screens/home/widgets/job_list.dart';

import 'package:cfit/screens/home/widgets/tag_list.dart';

import 'package:cfit/screens/home/widgets/home_app_bar.dart';
import 'package:cfit/screens/home/widgets/search_card.dart';

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({Key? key}) : super(key: key);


  void callEmoji() {
    print('Emoji Icon Pressed...');
  }

  void callAttachFile() {
    print('Attach File Icon Pressed...');
  }

  void callCamera() {
    print('Camera Icon Pressed...');
  }

  void callVoice() {
    print('Voice Icon Pressed...');
  }

  Widget moodIcon() {
    return IconButton(
        icon: const Icon(
          Icons.search_rounded,
          color: kInputTextColor,
        ),
        onPressed: () => callEmoji());
  }

  Widget attachFile() {
    return IconButton(
      icon: const Icon(Icons.attach_file, color: kInputTextColor),
      onPressed: () => callAttachFile(),
    );
  }

  Widget pesquisa() {
    return IconButton(
      icon: const Icon(Icons.send, color: kInputTextColor),
      onPressed: () => callCamera(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HomeAPpBar(),
                SizedBox(height: 40),
                Text('Suas Conquistas!!',
                    style: TextStyle(
                        fontSize: 28,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left),
                SizedBox(height: kDefaultPadding / 3),

                SearchCard(),
                SizedBox(height: kDefaultPadding / 3),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(children: [
                        Expanded(
                          child: Container(
                            child: Row(
                              children: [
                                Image.asset(Images.logo_name, width: 100,
                                  fit: BoxFit.contain,),
                                Center(
                                  child: Text(
                                    "Parabéns!! Você está \nhá 5 semanas se \nexercitando \nregulamente ",
                                    style: TextStyle(
                                        fontSize: 23,
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w600
                                    ),
                                      textAlign: TextAlign.left
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),

                      ]),



                    ],
                  ),
                ),

                SizedBox(height: 20),
                TagsList(),
                Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: JobList()),
              ],
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child:
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
            Widget>[
          Container(
            height: 80,
            margin: EdgeInsets.only(bottom: 2),
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
                Text('Suas Conquistas!!',
                    style: TextStyle(
                        fontSize: 28,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center),
                SizedBox(height: kDefaultPadding/2),
                SizedBox(height: kDefaultPadding / 3),

                Row(children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 7,
                              color: Colors.grey)
                        ],
                      ),
                      child: Row(
                        children: [
                          moodIcon(),
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Procure seus eventos...",
                                  hintStyle: TextStyle(color: kInputTextColor),
                                  border: InputBorder.none),
                            ),
                          ),
                          pesquisa(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),

                ]),

                SizedBox(height: kDefaultPadding / 3),

                Row(children: [
                  Expanded(
                    child: Container(
                      child: Row(
                        children: [
                          Image.asset(Images.logo_name, width: 100,
                            fit: BoxFit.contain,),
                          Center(
                            child: Text(
                              "Parabéns!! Você está \nhá 5 semanas se \nexercitando \nregulamente ",
                              style: TextStyle(
                                  fontSize: 23,
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),

                ]),

                SizedBox(height: 70),
                TagsList(),

                Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: JobList()),

              ],
            ),
          )
        ]),
      ),
    );
  }
}
