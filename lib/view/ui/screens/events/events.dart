import 'dart:ui';

import 'package:cfit/constants.dart';
import 'package:cfit/controller/user_controller.dart';
import 'package:cfit/infrastructure/navigation/routes.dart';
import 'package:cfit/view/ui/screens/events/controller/events.controller.dart';
import 'package:cfit/view/ui/screens/events/models/Events.models.dart';
import 'package:cfit/view/ui/screens/events/widgets/events_details.dart';
import 'package:cfit/view/ui/screens/maps/maps_events.dart';
import 'package:cfit/view/ui/screens/widgets/color_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EventsScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {
    Get.find<EventsController>().getEventsList(reload: true);
    Get.find<EventsController>().getModalidades(true, '', false);
    //Get.find<UserController>().getUserInfo();
    //Get.find<EventsController>().getEventsList(reload, 'all', false);
  }

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final _storage = Get.find<GetStorage>();

  final List<DateTime> events = [];

  var selectedList = 0;

  //final taglist = <String>['Todos', '⚡ Populares', '⭐ Favoritos'];
  List<EventModalidade> taglist = <EventModalidade>[
    EventModalidade(nome: 'Todos')
  ];

  double animacaoduracao = 2.4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        onRefresh: () async {
          EventsScreen.loadData(true);
        },
        child: GetBuilder<UserController>(builder: (userController) {
          return userController.userInfoModel.name == null
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
              : Stack(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                      ],
                    ),
                    GetBuilder<EventsController>(builder: (eventController) {
                      //eventController.getEventsList(reload: false);
                      eventController.getModalidades(false, '', false);

                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0.0),
                              color: kPrimaryColor,
                            ),
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).padding.top,
                                right: 25,
                                left: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => Get.toNamed(Routes.dashboard),
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xffffffff)),
                                      shape: BoxShape.circle,
                                      //color: Color(0xffffffff),
                                    ),
                                    child: const Icon(
                                      Icons.arrow_back,
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Eventos',
                                  style: TextStyle(
                                    fontSize: 28,
                                    color: Color(0xffffffff),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        //Get.toNamed(Routes.mapa);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EventsMaps()));
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 10, right: 10, bottom: 10),
                                        child: Stack(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/location.svg',
                                              color: Colors.white,
                                              matchTextDirection: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 10,
                              right: 10,
                              bottom: 0,
                              left: 20,
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  const Text(
                                    'Proximos Eventos',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  FloatingActionButton.extended(
                                    onPressed: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EventsMaps()))
                                      /*
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) => BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 5, sigmaY: 5),
                                          child: EventsAdd(),
                                        ),
                                      )*/
                                    },
                                    label: const Text('Criar Evento'),
                                    icon: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 10,
                              right: 20,
                              bottom: 0,
                              left: 20,
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  child: SvgPicture.asset(
                                    'assets/icons/esq.svg',
                                    color: Colors.black,
                                    matchTextDirection: true,
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 222, 222, 222),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Corrida',
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  color: Color(0xff000000),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Row(
                                                children: const [
                                                  Icon(Icons.person),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text('Gabriela Veras'),
                                                ],
                                              ),
                                              const Text('Endereço'),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text('17:30h'),
                                              Text('Endereço'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  child: SvgPicture.asset(
                                    'assets/icons/dir.svg',
                                    color: Colors.black,
                                    matchTextDirection: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            height: 30,
                            child: (eventController.modalidades.isEmpty)
                                ? const SizedBox()
                                : ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                          onTap: () {
                                            //setState(() {
                                            //print(eventController.modalidades[index].nome);
                                            selectedList = index;
                                            //});
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 20),
                                            decoration: BoxDecoration(
                                              color: selectedList == index
                                                  ? const Color(0xff12AA9E)
                                                  : const Color(0xff0A6960),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: selectedList == index
                                                    ? const Color(0xff12AA9E)
                                                    : const Color(0xff0A6960),
                                              ),
                                            ),
                                            child: Text(
                                              eventController
                                                  .modalidades[index].nome,
                                              style: const TextStyle(
                                                  color: Color(0xffffffff)),
                                            ),
                                          ),
                                        ),
                                    separatorBuilder: (_, index) =>
                                        const SizedBox(
                                          width: 8,
                                        ),
                                    itemCount:
                                        eventController.modalidades.length),
                          ),
                          const SizedBox(height: 20),
                          (eventController.modalidades.isEmpty)
                              ? Container(
                                  margin: const EdgeInsets.all(0),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Loading(),
                                      ],
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: SizedBox(
                                    height:
                                        eventController.modalidades.length * 80,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: ListView.separated(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) =>
                                            Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                eventController
                                                    .modalidades[index].nome,
                                                style: const TextStyle(
                                                  fontSize: 22,
                                                  color: Color(0xff000000),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 0),
                                                height: (eventController
                                                        .modalidades[index]
                                                        .eventos!
                                                        .isEmpty)
                                                    ? (eventController
                                                                .modalidades[
                                                                    index]
                                                                .statusLoading ==
                                                            false)
                                                        ? 20
                                                        : 20
                                                    : 130,
                                                child: (eventController
                                                        .modalidades[index]
                                                        .eventos!
                                                        .isEmpty)
                                                    ? (eventController
                                                                .modalidades[
                                                                    index]
                                                                .statusLoading ==
                                                            false)
                                                        ? const Text(
                                                            'Nenhum evento cadastrado.')
                                                        : Loading()
                                                    : ListView.separated(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemBuilder:
                                                            (context, index2) =>
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    showModalBottomSheet(
                                                                      isScrollControlled:
                                                                          true,
                                                                      context:
                                                                          context,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      builder:
                                                                          (context) =>
                                                                              BackdropFilter(
                                                                        filter: ImageFilter.blur(
                                                                            sigmaX:
                                                                                5,
                                                                            sigmaY:
                                                                                5),
                                                                        child: EventDetail(
                                                                            eventController.modalidades[index].eventos![index2],
                                                                            eventController,
                                                                            0),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: 270,
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            20),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          222,
                                                                          222,
                                                                          222),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  eventController.modalidades[index].eventos![index2].nome ?? '',
                                                                                  style: const TextStyle(
                                                                                    fontSize: 22,
                                                                                    color: Color(0xff000000),
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                                ),
                                                                                Row(
                                                                                  children: const [
                                                                                    Icon(Icons.person),
                                                                                    SizedBox(
                                                                                      width: 5,
                                                                                    ),
                                                                                    Text('Gabriela Veras'),
                                                                                  ],
                                                                                ),
                                                                                Text(eventController.modalidades[index].eventos![index2].rua ?? ''),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 20,
                                                                            ),
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: const [
                                                                                Text('17:30h'),
                                                                                Text('Endereço'),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                        separatorBuilder:
                                                            (_, index2) =>
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                        itemCount:
                                                            eventController
                                                                .modalidades[
                                                                    index]
                                                                .eventos!
                                                                .length),
                                              ),
                                            ],
                                          ),
                                        ),
                                        separatorBuilder: (_, index) =>
                                            const SizedBox(
                                          height: 15,
                                        ),
                                        itemCount:
                                            eventController.modalidades.length,
                                      ),
                                    ),
                                  ),
                                ),
                          /*
                          eventController.eventos.isEmpty
                              ? Container(
                                  margin: const EdgeInsets.all(0),
                                  child: Center(
                                    child: Loading(),
                                  ),
                                )
                              : Expanded(
                                  child:
                                      EventsList(controller: eventController),
                                ),
                                */
                        ],
                      );
                    }),
                  ],
                );
        }),
      ),
    );
  }
}
