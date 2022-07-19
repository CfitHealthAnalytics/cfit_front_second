import 'package:cfit/constants.dart';
import 'package:cfit/view/ui/screens/events.dart';
import 'package:cfit/view/ui/screens/home/home.screen.dart';
import 'package:cfit/view/ui/screens/perfil/perfil.dart';
import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'package:flutter/material.dart';

class PersistentTabVirePage extends StatefulWidget {
  const PersistentTabVirePage({Key? key}) : super(key: key);

  @override
  State<PersistentTabVirePage> createState() => _PersistentTabVirePageState();
}

class _PersistentTabVirePageState extends State<PersistentTabVirePage> {
  PersistentTabController? _controller;

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(name: ''),
      items: _navBarsItems(ctx: context),
      confineInSafeArea: true,
      backgroundColor:
          const Color.fromARGB(255, 39, 43, 48), // Default is Colors.white.

      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0.0),
        colorBehindNavBar: Colors.white,
      ),
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }
}

List<Widget> _buildScreens({required String name}) {
  return [
    HomeScreen(),
    EventsScreen(),
    Container(
      child: const Center(
        child: Text('EM BREVE'),
      ),
    ),
    Container(
      child: const Center(
        child: Text('EM BREVE'),
      ),
    ),
    PerfilScreen(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems({required BuildContext ctx}) {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.home),
      title: ("Início"),
      activeColorPrimary: const Color.fromARGB(255, 255, 255, 255),
      inactiveColorPrimary: const Color.fromARGB(190, 203, 203, 203),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.account_balance_wallet_outlined,
      ),
      title: ("Eventos"),
      activeColorPrimary: const Color.fromARGB(255, 255, 255, 255),
      inactiveColorPrimary: const Color.fromARGB(190, 203, 203, 203),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        CupertinoIcons.calendar_badge_plus,
        size: 35,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      title: ("Adicionar"),
      textStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      activeColorPrimary: const Color.fromARGB(255, 45, 115, 159),
      activeColorSecondary: const Color.fromARGB(255, 255, 255, 255),
      inactiveColorPrimary: const Color.fromARGB(189, 210, 210, 210),
      inactiveColorSecondary: kPrimaryColor,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.bell),
      title: ("Notificações"),
      activeColorPrimary: const Color.fromARGB(255, 255, 255, 255),
      inactiveColorPrimary: const Color.fromARGB(190, 203, 203, 203),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person),
      title: ("Perfil"),
      activeColorPrimary: const Color.fromARGB(255, 255, 255, 255),
      inactiveColorPrimary: const Color.fromARGB(190, 203, 203, 203),
    ),
  ];
}
