import 'package:cfit/view/ui/screens/events/controller/events.controller.dart';
import 'package:cfit/view/ui/screens/widgets/event_item.dart';
import 'package:flutter/material.dart';

class EventsList extends StatelessWidget {
  final EventsController controller;
  EventsList({required this.controller});

  //EventsList({Key? key}) : super(key: key);

  double TimeAnimacao = 1.3;

  SetTime() {
    TimeAnimacao = TimeAnimacao + 0.3;
    return TimeAnimacao;
  }

  @override
  Widget build(BuildContext context) {
    final eventsList = controller.eventos;

    /*Future<EventsModels> getEventos =
        Get.find<AuthController>().getCityEvents();
    print(getEventos);
    */

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => EventItem(
        evento: eventsList[index],
        eventController: controller,
        showTime: true,
      ),
      separatorBuilder: (_, index) => const SizedBox(
        height: 15,
      ),
      itemCount: eventsList.length,
    );
  }
}
