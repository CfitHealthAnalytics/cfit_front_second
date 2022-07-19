import 'dart:ui';

import 'package:cfit/controller/user_controller.dart';
import 'package:cfit/infrastructure/navigation/routes.dart';
import 'package:cfit/view/ui/screens/events/controller/events.controller.dart';
import 'package:cfit/view/ui/screens/events/event_edit.dart';
import 'package:cfit/view/ui/screens/events/models/Events.models.dart';
import 'package:cfit/view/ui/screens/events/widgets/events_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventList extends StatefulWidget {
  const EventList(
      {Key? key,
      required this.event,
      required this.eventController,
      required this.tipo})
      : super(key: key);

  final EventsModel event;
  final EventsController eventController;
  final int tipo;

  @override
  State<EventList> createState() => _JobItemState();
}

class _JobItemState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    String idUser = Get.find<UserController>().idLocal;
    return GestureDetector(
      onTap: () {
        if (widget.event.user_id_create == idUser) {
          //Get.to(EventEdit())

          Get.toNamed(Routes.getEventEditRoute(widget.event.id ?? ''),
              arguments: EventEdit(event: widget.event));
        } else {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: EventDetail(
                  widget.event, widget.eventController, widget.tipo),
            ),
          );
        }

        /*
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child:
                EventDetail(widget.event, widget.eventController, widget.tipo),
          ),
        );
        */
      },
      child: Container(
        width: (widget.event.nome!.length < 50) ? 270 : 270,
        height: 130,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 222, 222, 222),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: <Widget>[
                Flexible(
                  child: Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.event.nome ?? '',
                          style: const TextStyle(
                            fontSize: 22,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.person),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('Gabriela Veras'),
                                  ],
                                ),
                                Text(widget.event.rua ?? ''),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('17:30h'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
