import 'package:cfit/constants.dart';
import 'package:cfit/controller/user_controller.dart';
import 'package:cfit/util/dimensions.dart';
import 'package:cfit/view/ui/screens/events/controller/events.controller.dart';
import 'package:cfit/view/ui/screens/events/widgets/event_list.dart';
import 'package:cfit/view/ui/screens/home/widgets/home_app_bar.dart';
import 'package:cfit/view/ui/screens/widgets/color_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cfit/controller/auth_controller.dart';

//import 'package:firebase_auth/firebase_auth.dart';
//

import 'package:get_storage/get_storage.dart';

//import 'package:connectivity/connectivity.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

  final _storage = Get.find<GetStorage>();

  /*
  @override
  void initState() {
    super.initState();
    //if (_isLoggedIn && Get.find<UserController>().userInfoModel == null) {
    Get.find<UserController>().getUserInfo();
    //}
  }
  */

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// CURRENT WIDTH AND HEIGHT
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

    if (_isLoggedIn) {
      //Get.find<AuthController>().getUser();
    }

    //String qrData = "CFjzbLMGuoiaXsd7oMpBH3O7tXSv7221111997M";
    return GetBuilder<UserController>(builder: (userController) {
      //return const Center(child: CircularProgressIndicator());
      userController.checkLogin();
      return GetBuilder<EventsController>(builder: (eventController) {
        eventController.getMyCityEvents(false, '', false);
        eventController.getMyPublicEvents(false, '', false);

        return Scaffold(
          //appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() : null,
          //endDrawer: MenuDrawer(),
          backgroundColor: Theme.of(context).cardColor,
          body: RefreshIndicator(
            onRefresh: () async {
              eventController.getMyCityEvents(true, '', false);
              eventController.getMyPublicEvents(true, '', false);
            },
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top, right: 25, left: 25),
              child: CustomScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        width: Dimensions.WEB_MAX_WIDTH,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 40),
                            HomeAPpBar(),
                            const SizedBox(height: 40),
                            Container(
                              width: (Get.width * 0.9),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xff000000),
                                ),
                              ),
                              child: const Text(
                                'Meus Eventos',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: kDefaultPadding / 3),
                            const SizedBox(height: kDefaultPadding / 3),

                            //TagsList(),
                            SizedBox(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Academia da Cidade',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      height: (eventController
                                              .my_city_events.isEmpty)
                                          ? 40
                                          : 130,
                                      child: (eventController
                                              .my_city_events.isEmpty)
                                          ? (eventController
                                                      .my_city_events_loading ==
                                                  false)
                                              ? const Text(
                                                  'Nenhum evento cadastrado.')
                                              : Container(
                                                  child: Column(
                                                    children: [
                                                      Loading(),
                                                    ],
                                                  ),
                                                )
                                          : Expanded(
                                              child: ListView.separated(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, index2) =>
                                                          EventList(
                                                            event: eventController
                                                                    .my_city_events[
                                                                index2],
                                                            eventController:
                                                                eventController,
                                                            tipo: 0,
                                                          ),
                                                  separatorBuilder:
                                                      (_, index2) =>
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                  itemCount: eventController
                                                      .my_city_events.length),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            SizedBox(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Eventos Publicos',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      height: (eventController
                                              .my_public_events.isEmpty)
                                          ? 40
                                          : 130,
                                      child: (eventController
                                              .my_public_events.isEmpty)
                                          ? (eventController
                                                      .my_public_events_loading ==
                                                  false)
                                              ? const Text(
                                                  'Nenhum evento cadastrado.')
                                              : Container(
                                                  child: Column(
                                                    children: [
                                                      Loading(),
                                                    ],
                                                  ),
                                                )
                                          : ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index2) =>
                                                  EventList(
                                                    event: eventController
                                                            .my_public_events[
                                                        index2],
                                                    eventController:
                                                        eventController,
                                                    tipo: 1,
                                                  ),
                                              separatorBuilder: (_, index2) =>
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                              itemCount: eventController
                                                  .my_public_events.length),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //HomeAPpBar(),

                  /*userController.userInfoModel.name == null
                    ? Container(
                        margin: const EdgeInsets.all(0),
                        child: const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.grey,
                            color: Colors.green,
                            strokeWidth: 5,
                            value: 3,
                          ),
                        ),
                      )
                    : SizedBox(
                        //margin: const EdgeInsets.all(17),
                        width: w,
                        height: h,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              /// FLUTTER IMAGE
                              const SizedBox(height: 40),
                              HomeAPpBar(),
                              const SizedBox(height: 40),
                              Container(
                                width: (Get.width * 0.9),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0xff000000),
                                  ),
                                ),
                                child: const Text(
                                  'Meus Eventos',
                                  style: TextStyle(
                                    fontSize: 28,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: kDefaultPadding / 3),
                              const SizedBox(height: kDefaultPadding / 3),
                              TagsList(),

                              const SizedBox(height: 20),

                              Container(
                                margin: const EdgeInsets.only(bottom: 40),
                                child: JobList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      */
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}

/*

class HomeScreen2 extends GetView<HomeController> {
  final _storage = Get.find<GetStorage>();

  final int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  /*static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    EventsScreen(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];
  */

  Future<List<EventModalidade>> modalidades() async {
    return await Get.find<HomeController>().getModalidades();
  }

  @override
  Widget build(BuildContext context) {
    /// CURRENT WIDTH AND HEIGHT
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

    if (_isLoggedIn) {
      Get.find<AuthController>().getUser();
    }

    Get.find<EventsController>().getEventsList(false, 'all', false);
    //Get.find<EventsController>().getEventsFavoriteList(false, 'all', false);

    void _onItemTapped(int index) {
      if (index == 1) {
        Get.toNamed(Routes.eventos);
        //Get.offAllNamed(Routes.usuarios);
      }

      if (index == 2) {
        Get.toNamed(Routes.mymeasures);
      }

      if (index == 3) {
        Get.toNamed(Routes.perfil);
      }

      //setState(() {
      //_selectedIndex = index;
      //});
    }

    //UserModel Ts = UserModel.fromData();
    //print(Ts);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        /// Body
        body: GetBuilder<HomeController>(builder: (homeController) {
          return SizedBox(
            //margin: const EdgeInsets.all(17),
            width: w,
            height: h,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// FLUTTER IMAGE
                  const SizedBox(height: 40),
                  HomeAPpBar(),
                  const SizedBox(height: 40),
                  const Text(
                    'Suas Conquistas!!',
                    style: TextStyle(
                        fontSize: 28,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: kDefaultPadding / 3),
                  const SearchCard(),
                  const SizedBox(height: kDefaultPadding / 3),
                  TagsList(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  FadeAnimation(
                                    delay: 2.3,
                                    child: Image.asset(
                                      Images.logo_name,
                                      width: 100,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const Center(
                                    child: Text(
                                        "Parabéns!! Você está \nhá 5 semanas se \nexercitando \nregulamente ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.left),
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
                  const SizedBox(height: 20),

                  Container(
                      margin: const EdgeInsets.only(bottom: 40),
                      child: JobList()),
                ],
              ),
            ),
          );
        }),
        /*
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              label: 'Eventos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.construction),
              label: 'Medidas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: kPrimaryColor,
          onTap: _onItemTapped,
        ),
        */
      ),
    );

    /*
    return BaseWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('HomeScreen'),
          centerTitle: true,
        ),
        body: Center(
          child: Obx(
            () => Text(
              'Logado com: ${controller.userGet.value?.name ?? 'Ops'}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
    */
  }
}
*/
