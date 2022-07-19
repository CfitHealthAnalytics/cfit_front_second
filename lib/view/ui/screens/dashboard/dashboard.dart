import 'dart:async';

import 'package:cfit/controller/user_controller.dart';
import 'package:cfit/helper/responsive_helper.dart';
import 'package:cfit/util/Images.dart';
import 'package:cfit/util/dimensions.dart';
import 'package:cfit/view/ui/screens/dashboard/widget/bottom_nav_item.dart';
import 'package:cfit/view/ui/screens/events/events.dart';
import 'package:cfit/view/ui/screens/events/events_academia.dart';
import 'package:cfit/view/ui/screens/home/home.screen.dart';
import 'package:cfit/view/ui/screens/perfil/perfil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  const DashboardScreen({required this.pageIndex});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _pageIndex = 1;
  List<Widget> _screens = [];
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;

  @override
  void initState() {
    super.initState();

    //Get.find<EventsController>().getModalidades();

    _pageIndex = widget.pageIndex;

    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
      HomeScreen(),
      EventsAcademyScreen(),
      EventsScreen(),
      PerfilScreen(),
      Container(),
    ];

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
    });

    /*if(GetPlatform.isMobile) {
      NetworkInfo.checkConnectivity(_scaffoldKey.currentContext);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController) {
      //return const Center(child: CircularProgressIndicator());
      //print(userController.userInfoModel.name);
      return userController.userInfoModel.name == null
          ? const Center(child: CircularProgressIndicator())
          : WillPopScope(
              onWillPop: () async {
                if (_pageIndex != 0) {
                  _setPage(0);
                  return false;
                } else {
                  if (_canExit) {
                    return true;
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('back_press_again_to_exit'.tr,
                          style: const TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                      margin:
                          const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                    _canExit = true;
                    Timer(const Duration(seconds: 2), () {
                      _canExit = false;
                    });
                    return false;
                  }
                }
              },
              child: Scaffold(
                key: _scaffoldKey,
                floatingActionButton: ResponsiveHelper.isDesktop(context)
                    ? null
                    : null /*FloatingActionButton(
                elevation: 5,
                backgroundColor: _pageIndex == 2
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor,
                onPressed: () => _setPage(2),
                child: const Text('Cart'),
              )*/
                ,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                bottomNavigationBar: ResponsiveHelper.isDesktop(context)
                    ? const SizedBox()
                    : BottomAppBar(
                        elevation: 5,
                        notchMargin: 5,
                        clipBehavior: Clip.antiAlias,
                        shape: const CircularNotchedRectangle(),
                        child: Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: Row(children: [
                            BottomNavItem(
                                iconData: Images.IconHome,
                                isSelected: _pageIndex == 0,
                                onTap: () => _setPage(0)),
                            BottomNavItem(
                                iconData: Images.IconAcademia,
                                isSelected: _pageIndex == 1,
                                onTap: () => _setPage(1)),
                            //const Expanded(child: SizedBox()),
                            BottomNavItem(
                                iconData: Images.IconEventos,
                                isSelected: _pageIndex == 2,
                                onTap: () => _setPage(2)),
                            BottomNavItem(
                                iconData: Images.IconProfile,
                                isSelected: _pageIndex == 3,
                                onTap: () => _setPage(3)),
                          ]),
                        ),
                      ),
                body: PageView.builder(
                  controller: _pageController,
                  itemCount: _screens.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _screens[index];
                  },
                ),
              ),
            );
    });
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
