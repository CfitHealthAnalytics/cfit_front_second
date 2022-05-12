import 'package:cfit/screens/home/home_screen2.dart';
import 'package:cfit/screens/login/login_screen.dart';
import 'package:cfit/screens/qr/qr.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:bottom_bar/bottom_bar.dart';

import 'package:cfit/components/custom_button.dart';
import 'package:cfit/components/social_button.dart';
import 'package:cfit/constants.dart';
import 'package:cfit/responsive.dart';
import 'package:cfit/screens/register/register_screen.dart';
import 'package:cfit/util/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  State createState() => _State();
}

class _State extends State<InitScreen> {
  int _currentPage = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          HomeScreen2(),
          Container(color: Colors.red),
          Qr(),
          Container(color: Colors.orange),
          Container(color: Colors.orange),
        ],
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _currentPage,
        showActiveBackgroundColor: true,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.blue,
          ),
          BottomBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorito'),
            activeColor: Colors.red,
            darkActiveColor: Colors.red.shade400,
          ),
          BottomBarItem(
            icon: Icon(Icons.person),
            title: Text('Medidas'),
            activeColor: Colors.greenAccent.shade700,
            darkActiveColor: Colors.greenAccent.shade400,
          ),
          BottomBarItem(
            icon: Icon(Icons.settings),
            title: Text('Configuração'),
            activeColor: Colors.orange,
          ),
          BottomBarItem(
            icon: Icon(Icons.menu),
            title: Text('Menu'),
            activeColor: Colors.orange,
          ),
        ],
      ),
    );
  }
/*
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (_) => HelloConvexAppBar(),
        "/bar": (BuildContext context) => LoginScreen(),
        "/custom": (BuildContext context) => RegisterScreen(),
        "/fab": (BuildContext context) => LoginScreen(),
      },
    );
  }*/
}

class HelloConvexAppBar extends StatelessWidget {
  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CFIT'),
        backgroundColor: kPrimaryColor,
      ),
      body: Center(
          child: TextButton(
        child: Text('Click to show full example'),
      )),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        items: [
          TabItem(icon: Icons.list),
          TabItem(icon: Icons.calendar_today),
          TabItem(icon: Icons.assessment),
        ],
        initialActiveIndex: 1,
        onTap: (int i) => print('click index=$i'),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 120,
                  margin: EdgeInsets.only(bottom: 4),
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
                  child: Image.asset(Images.logo_name, width: 100),
                ),
                SizedBox(height: kDefaultPadding),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Home',
                          style: TextStyle(
                              fontSize: 32,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center),
                      SizedBox(height: kDefaultPadding / 3),
                      Text(
                        'Digite seu E-mail',
                        style: TextStyle(
                            fontSize: 16,
                            color: kINputLabelColor,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: kDefaultPadding / 3),
                      TextField(
                        style: TextStyle(
                            color: kInputTextColor,
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            fillColor: kInputColor,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding / 2),
                            prefix: Padding(
                              padding:
                              EdgeInsets.only(right: kDefaultPadding / 4),
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
                        'Digite sua Senha',
                        style: TextStyle(
                            fontSize: 16,
                            color: kINputLabelColor,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: kDefaultPadding / 3),
                      TextField(
                        style: TextStyle(
                            color: kInputTextColor,
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            fillColor: kInputColor,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding / 2),
                            prefix: Padding(
                              padding:
                              EdgeInsets.only(right: kDefaultPadding / 4),
                              child: Text(
                                '',
                                style: TextStyle(
                                    color: kInputTextColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                      ),
                      SizedBox(height: kDefaultPadding / 2),
                      CustomButton(tap: () {}, text: 'Entrar'),
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
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()),
                            );
                          },
                          text: 'Criar Minha Conta'),
                      SizedBox(height: kDefaultPadding / 2),
                      Row(children: [
                        Expanded(
                          child: SocialButton(
                            tap: () {},
                            icon: 'assets/icons/google.svg',
                            color: kGoogleColor,
                          ),
                        ),
                        SizedBox(width: kDefaultPadding / 2),
                        Expanded(
                          child: SocialButton(
                            tap: () {},
                            icon: 'assets/icons/fb.svg',
                            color: kFbColor,
                          ),
                        ),
                      ]),
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
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.react,
          items: [
            TabItem(icon: Icons.list),
            TabItem(icon: Icons.calendar_today),
            TabItem(icon: Icons.assessment),
          ],
          initialActiveIndex: 1,
          onTap: (int i) => {print('click index=$i')},
          //onTap: (int i) => {print('click index=$i')},
        ));
  }
}
