//import 'dart:ffi';

import 'package:cfit/view/ui/screens/events/controller/events.controller.dart';
import 'package:cfit/view/ui/screens/events/models/Events.models.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

@immutable
class TagsList extends StatelessWidget {
  TagsList({Key? key}) : super(key: key);

  var selectedList = 0;

  //final taglist = <String>['Todos', '⚡ Populares', '⭐ Favoritos'];
  List<EventModalidade> taglist = <EventModalidade>[
    EventModalidade(nome: 'Todos')
  ];

  double animacaoduracao = 2.4;

  AnimationDuracao() {
    animacaoduracao = animacaoduracao + 0.4;
    return animacaoduracao;
  }

  static Future<void> loadData(bool reload) async {
    await Get.find<EventsController>().getModalidades(true, 'all', false);
  }

  @override
  void initState() {
    loadData(false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      height: 30,
      child: GetBuilder<EventsController>(builder: (eventController) {
        eventController.getModalidades(false, 'all', false);
        return (eventController.modalidades.isEmpty)
            ? const SizedBox()
            : ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
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
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedList == index
                                ? const Color(0xff12AA9E)
                                : const Color(0xff0A6960),
                          ),
                        ),
                        child: Text(
                          eventController.modalidades[index].nome,
                          style: const TextStyle(color: Color(0xffffffff)),
                        ),
                      ),
                    ),
                separatorBuilder: (_, index) => const SizedBox(
                      width: 8,
                    ),
                itemCount: eventController.modalidades.length);
      }),
    );
  }
}
